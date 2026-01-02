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
# Nettoyage du CSV
# ======================
awk -F',' '
$1=="nom" {print; ok=1; next}
ok && NF==3 {print}
' "$CSV" > clean.csv

# ======================
# 1️⃣ Tri par département
# ======================
{
  head -n1 clean.csv
  tail -n +2 clean.csv | sort -t',' -k2,2
} > sites-depts.csv

# ======================
# 2️⃣ Tri par visiteurs
# ======================
{
  head -n1 clean.csv
  tail -n +2 clean.csv | sort -t',' -k3,3nr -k2,2
} > sites-visites.csv

# ======================
# 3️⃣ Visiteurs par région
# ======================
awk -F',' '
NR>1 { dept[$2]+=$3 }
END {
  while ((getline < "REGIONS") > 0) {
    split($0,a,"=")
    region=a[1]
    gsub(/ /,"",a[2])
    split(a[2],d,",")
    total=0
    for (i in d)
      total+=dept[d[i]]
    print region","total
  }
}
' clean.csv |
sort -t',' -k2,2nr |
{
  echo "region,visiteurs_annuels"
  cat
} > regions-visites.csv

# ======================
# Nettoyage
# ======================
rm clean.csv

echo "✔ Fichiers générés :"
echo " - sites-depts.csv"
echo " - sites-visites.csv"
echo " - regions-visites.csv"
