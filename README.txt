Traitement des fichier pour les pdf:

-pour le document excel:
				-le mettre sous csv avec le format car il sera plus simple à modifier comme ça :
						nom_lieux:num_dept:nb_visiteur
retirer le titre 
-pour le fichier depts:
			-mettre en tableau avec le php lines(“nom_fichier”)
			-ATTENTION il faudra faire +1 a la clé pour avoir bien 
				la relation [num_dept] = nom_dept
			-le num 20 = 2A et 21 = 2B (vive la corse….)
			- ATTENTION a partir de l’indice 22 il faut plus faire +1 mais +2

-pour le fichier regions :
-on transforme le fichier en tableau de la forme 	[nom_région] = liste_num_depts 
-puis on utilise la tableau obtenue via le fichier depts pour avoir avoir un tableau de la forme [nom_région]= liste_nom_depts



utiliser pour lancer un docker:

docker container run -d --name [nom container] [image] tail -f /dev/null

(tail -f /dev/null) permet de maintenir le container vivant