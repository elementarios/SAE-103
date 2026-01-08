#!/bin/bash
set -e

# ======================
# Vérification argument
# ======================
if [ $# -ne 1 ]; then
  echo "Usage: $0 fichier.xlsx"
  exit 1
fi

XLSX="$1"
CSV="${XLSX%.xlsx}.csv"

# ======================
# XLSX -> CSV (Docker)
# ======================
docker run --rm \
  -v "$PWD:/data" \
  -w /data \
  bigpapoo/sae103-excel2csv \
  ssconvert "$XLSX" "$CSV"

# ======================
# 1️⃣ Tri par département
# ======================
{
  head -n1 "$CSV"
  tail -n +2 "$CSV" | while IFS=',' read -r nom dept visiteurs; do
    # clé de tri temporaire pour 2A/2B
    if [ "$dept" = "2A" ]; then sort_key=20
    elif [ "$dept" = "2B" ]; then sort_key=21
    else sort_key=$dept
    fi
    echo "$sort_key,$nom,$dept,$visiteurs"
  done | sort -t',' -k1,1n | cut -d',' -f3-
} > sites-depts.csv

# ======================
# 2️⃣ Tri par visiteurs
# ======================
{
  head -n1 "$CSV"
  tail -n +2 "$CSV" | while IFS=',' read -r nom dept visiteurs; do
    if [ "$dept" = "2A" ]; then sort_key=20
    elif [ "$dept" = "2B" ]; then sort_key=21
    else sort_key=$dept
    fi
    # tri principal sur visiteurs, secondaire sur département
    echo "$visiteurs,$sort_key,$nom,$dept"
  done | sort -t',' -k1,1nr -k2,2n | cut -d',' -f3-
} > sites-visites.csv

# ======================
# 3️⃣ Visiteurs par région (méthode REGIONS)
# ======================
echo "region,visiteurs_annuels" > regions-visites.csv

# Pour chaque région du fichier REGIONS
while IFS='=' read -r region depts_liste; do
  # Supprimer espaces
  depts_liste=$(echo "$depts_liste" | tr -d ' ')
  total_region=0

  # Parcourir chaque département de la région
  IFS=',' read -r -a depts <<< "$depts_liste"
  for dept_code in "${depts[@]}"; do
    # Conversion Corse pour le calcul
    if [ "$dept_code" = "2A" ]; then dept_code=20
    elif [ "$dept_code" = "2B" ]; then dept_code=21
    fi

    # Parcourir le CSV pour sommer les visiteurs de ce département
    tail -n +2 "$CSV" | while IFS=',' read -r nom dept visiteurs; do
      if [ "$dept" = "2A" ]; then dept=20
      elif [ "$dept" = "2B" ]; then dept=21
      fi
      if [ "$dept" = "$dept_code" ]; then
        total_region=$(( total_region + visiteurs ))
      fi
    done
  done

  # Afficher total pour la région
  echo "$region,$total_region"
done < REGIONS |
sort -t',' -k2,2nr >> regions-visites.csv

# ======================
# Fin
# ======================
echo "✔ Fichiers générés :"
echo " - sites-depts.csv"
echo " - sites-visites.csv"
echo " - regions-visites.csv"
