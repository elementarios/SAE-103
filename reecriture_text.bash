#!/usr/bin/bash

Entre="$1"
Sortie="$2"

if [[ -z "$Entre" || -z "$Sortie" ]]; then
    echo "Usage: $0 fichier_source fichier_html"
    exit 1
fi

# En tête de la page HTML
printf '%s\n' \
'<!DOCTYPE html>' \
'<html lang="fr">' \
'<head>' \
'    <meta charset="UTF-8">' \
'    <title>Document généré</title>' \
'</head>' \
'<body>' \
> "$Sortie"

# On lit chaque ligne du fichier et on pose les balises HTML là où on en a besoin
while IFS= read -r line; do

    # Dans le cas de la balise titre on mets un h1
    if [[ "$line" == TITLE=* ]]; then
        echo "<h1>${line#TITLE=}</h1>" >> "$Sortie"
    # Sinon dans tout les autres cas on mets une balise p
    elif [[ "$line" == *=* ]]; then
        echo "<p>${line#*=}</p>" >> "$Sortie"

    fi

done < "$Entre"

# On ferme les balises HTML
printf '%s\n' '</body>' '</html>' >> "$Sortie"
