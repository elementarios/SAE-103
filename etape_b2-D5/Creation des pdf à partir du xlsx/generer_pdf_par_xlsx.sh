#!/bin/bash

# Nettoyage des fichiers Windows si besoin


# | Nous avons rencontrés des problèmes d'exécution de scripts bash et php à cause de fins -    |
# | de lignes Windows                                                                           |
# |                                                                                             |                                                                                                               
# | Alors après quelques recherches, nous avons trouvés une solution à ce problème :            |
# |                                                                                             |
# | sed --> lance l'éditeur Stream Editor                                                       |
# |                                                                                             |
# | -i --> modifie les fichiers en place sans en ajouter un nouveau                             |
# |                                                                                             | 
# | 's/\r$//' --> substitué les caractères windows de fin de ligne (\r) qui sont donc en -      |
# | fin de ligne ($) par des fins de lignes linux (//)                                          |
# |                                                                                             |
# | *.sh, *.bash, *.php --> effectue ces actions sur tous les fichiers avec ces extensions      |
# |                                                                                             |                                 
# | 2>/dev/null --> redirige les messages d'erreurs vers null (utile si aucun fichier avec -    |
# | cette extension n'existe pour éviter d'afficher des messages d'erreurs inutiles)            |
# |                                                                                             |                             
# | Nous avons préférés incorporer cette commande dans le script principal pour -               | 
# | s'assurer que tous les scripts fonctionnent correctement                                    |
# |                                                                                             |
# | même si l'utilisateur a modifié les scripts sur un système Windows avant de les exécuter    |
# | dans un environnement Linux.                                                                |

sed -i 's/\r$//' *.sh 2>/dev/null
sed -i 's/\r$//' *.bash 2>/dev/null
sed -i 's/\r$//' *.php 2>/dev/null
chmod +x Création_csv.bash

echo "--- Étape 1 : Génération des CSV ---"
./Création_csv.bash "sites_touristiques_france v2.xlsx"

generer_pdf() {
    local csv=$1
    local titre=$2
    local sortie=$3

    echo "Traitement de : $titre"

    # Utilisation de sh -c pour éviter les erreurs de modification automatique des commandes
    # Génération du HTML intermédiaire
    #on utilise le conteneur bigpapoo/sae103-excel2csv car il contient php 
    docker run --rm -v "$PWD":/work -w /work bigpapoo/sae103-excel2csv \
        sh -c "php csv2html.php '$csv' '$titre'" > temp.html

    if [ ! -s temp.html ]; then
        echo "ERREUR : Le HTML n'a pas pu être généré pour $csv"
        return
    fi
    #(si le fichier temp n'a pas été généré on le précise)
    # Conversion PDF avec Weasyprint
    docker run --rm -v "$PWD":/data -w /data bigpapoo/sae103-html2pdf \
        weasyprint temp.html "$sortie"

    rm -f temp.html
    echo "Fichier $sortie généré."
}
#utilisation de la fonction pour chaques fichiers csv générés par le script précédent
echo "--- Étape 2 : Création des PDF ---"
generer_pdf "sites-depts.csv" "Sites Touristiques par Département" "sites_par_departement.pdf"
generer_pdf "sites-visites.csv" "Classement des Visites" "sites_les_plus_visites.pdf"
generer_pdf "regions-visites.csv" "Statistiques par Région" "visites_par_region.pdf"

echo "Terminé !"
# Enjoy