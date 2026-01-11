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
# XLSX -> CSV
# ======================
docker run --rm \
  -v "$PWD:/data" \
  -w /data \
  bigpapoo/sae103-excel2csv \
  ssconvert "$XLSX" "$CSV"

# ======================
# Nettoyage simple (bash)
# ======================
> clean.csv

while IFS=',' read -r nom dept visiteurs
do
  # on garde l'en-tête
  if [ "$nom" = "nom" ]; then
    echo "$nom,$dept,$visiteurs" >> clean.csv
  else
    # on garde uniquement les lignes complètes
    if [ -n "$nom" ] && [ -n "$dept" ] && [ -n "$visiteurs" ]; then
      echo "$nom,$dept,$visiteurs" >> clean.csv
    fi
  fi
done < "$CSV"

# ======================
# 1️⃣ Tri par département
# ======================
head -n 1 clean.csv > sites-depts.csv
tail -n +2 clean.csv | sort -t',' -k2,2 >> sites-depts.csv

# ======================
# 2️⃣ Tri par visiteurs
# ======================
head -n 1 clean.csv > sites-visites.csv
tail -n +2 clean.csv | sort -t',' -k3,3nr >> sites-visites.csv

# ======================
# 3️⃣ Visiteurs par région
# ======================
echo "region,visiteurs_annuels" > regions-visites.csv

while IFS='=' read -r regions depts
do
  total=0

  # boucle sur les départements de la région
  for dept in $(echo "$depts" | tr ',' ' ')
  do
    # boucle sur le CSV
    while IFS=',' read -r nom d v
    do
      if [ "$nom" != "nom" ] && [ "$d" = "$dept" ]; then
        total=$((total + v))
      fi
    done < clean.csv
  done

  echo "$region,$total" >> regions-visites.csv

done < REGIONS

# Tri final des régions
head -n 1 regions-visites.csv > tmp.csv
tail -n +2 regions-visites.csv | sort -t',' -k2,2nr >> tmp.csv
mv tmp.csv regions-visites.csv

# ======================
# Nettoyage
# ======================
rm clean.csv

echo "✔ Fichiers générés :"
echo " - sites-depts.csv"
echo " - sites-visites.csv"
echo " - regions-visites.csv"
