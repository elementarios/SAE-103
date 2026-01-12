<?php
# Récupération des arguments
$fichierCsv = $argv[1];
$titreDoc = $argv[2];

# Ouverture du fichier CSV et vérification
$handle = fopen($fichierCsv, "r");
if (!$handle) exit("Erreur ouverture CSV\n");

# Début du document HTML avec css intégrés sous baslise <style>
# Ensuite on génère le header
# Puis on empêche le pdf de prendre plusieures pages en utilisant des colonnes CSS
# Enfin on génère le(s) tableau
echo "<!DOCTYPE html><html lang='fr'><head><meta charset='UTF-8'><style>
    /* Configuration de la page A4 */
    @page { size: A4 portrait; margin: 1cm; }
    body { font-family: Arial, sans-serif; margin: 0; padding: 0; font-size: 8px; }
    
    header { 
        display: flex; 
        justify-content: space-between; 
        align-items: center; 
        border-bottom: 2px solid #2c3e50; 
        margin-bottom: 10px;
        height: 60px;
    }
    header h1 { margin: 0; color: #2c3e50; font-size: 18px; }
    .logo { height: 50px; }

    .content { 
        height: 24cm; /* Hauteur max pour tenir sur un A4 avec le header */
        column-count: 3; 
        column-gap: 35px;
        column-fill: auto;
        column-rule: 0.5px solid #eee;
        
    }
    
    table { 
        width: 100%; 
        border-collapse: collapse; 
        margin-bottom: 0;
    }
    th, td { 
        border: 0.1px solid #999; 
        padding: 3px 5px; 
        text-align: left; 
        overflow: hidden;
    }
    th { background: #2c3e50; color: white; text-transform: uppercase; }
    tr:nth-child(even) { background: #f9f9f9; }

    /* Évite qu'une ligne soit coupée en deux entre deux colonnes */
    tr { break-inside: avoid; }
</style></head><body>

<header>
    <h1>$titreDoc</h1>
    <img src='logo.png' class='logo' alt='Offices de Tourisme'>
</header>

<div class='content'>";

# Lecture du CSV et génération du tableau HTML
$entete = fgetcsv($handle, 1000, ",");
echo "<table><thead><tr>";
foreach ($entete as $h) {
    echo "<th>" . htmlspecialchars(trim($h)) . "</th>"; #evite l'affichage de caractere speciaux et indésirables
}
echo "</tr></thead><tbody>";

while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) { #boucle pour lire toutes les lignes
    echo "<tr>";
    foreach ($data as $cell) {
        // Nettoyage des données (enlève les guillemets ou \n résiduels)
        $clean = trim($cell, " \n\r\t\v\0\""); #empêche les caractères listés d'apparaitre
        echo "<td>" . htmlspecialchars($clean) . "</td>";
    }
    echo "</tr>";
}

echo "</tbody></table></div></body></html>";
fclose($handle);# Fermer le fichier pour éviter de le verrouiller si il doit etre réutilisé
?>