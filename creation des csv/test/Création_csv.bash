#!/bin/bash
set -e

XLSX="$1"
CSV="${XLSX%.xlsx}.csv"

# Conversion du ficher xlsx en csv
docker run --rm \
  -v "$PWD:/data" \
  -w /data \
  bigpapoo/sae103-excel2csv \
  ssconvert "$XLSX" "$CSV"

# ======================
# Nettoyage du CSV
# (garder l'entête + lignes à 3 colonnes)
# ======================
> clean.csv

while IFS=',' read -r col1 col2 col3 reste
do
  if [ "$col1" = "nom" ]; then
    echo "$col1,$col2,$col3" >> clean.csv
  elif [ -n "$col1" ] && [ -n "$col2" ] && [ -n "$col3" ] && [ -z "$reste" ]; then
    echo "$col1,$col2,$col3" >> clean.csv
  fi
done < "$CSV"



# On créer le premier fichier en triant par département
head -n 1 clean.csv > sites-depts.csv
tail -n +2 clean.csv | sort -t',' -k2,2 >> sites-depts.csv

# On créer le deuxième fichier en triant par nombre de visiteurs décroissant
head -n 1 clean.csv > sites-visites.csv
tail -n +2 clean.csv | sort -t',' -k3,3nr -k2,2 >> sites-visites.csv

# On créer le troisième fichier en triant par régions ayant le plus de 
#   visiteurs, on fait la somme des visiteurs par région
echo "region,visiteurs_annuels" > regions-visites.csv

while IFS='=' read -r region depts
do
  total=0

  for dept in $(echo "$depts" | tr ',' ' ')
  do
    while IFS=',' read -r nom d v
    do
      if [ "$d" = "$dept" ]; then
        total=$(( total + v ))
      fi
    done < <(tail -n +2 clean.csv)
  done

  echo "$region,$total" >> regions-visites.csv

done < REGIONS

# Une fois toute les lignes créer on trie par nombre de visiteurs décroissants
# On passe par un fichier temporaire pour pouvoir garder l'entête, 
#   on trie le contenue puis on ajoute le contenue trié à l'entête
head -n 1 regions-visites.csv > tmp.csv
tail -n +2 regions-visites.csv | sort -t',' -k2,2nr >> tmp.csv
mv tmp.csv regions-visites.csv

# ======================
# Nettoyage
# ======================
rm clean.csv

