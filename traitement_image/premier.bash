#!/usr/bin/bash

#on prepare la zone de travail
docker run -dit --name image --user root sae103-imagick  #changer  en bigpapoo/sae103-imagick si vous n'etes pas a l'iut
docker container cp ./traitement_image/deuxieme.bash image:/home
docker container exec image mkdir /home/Ntraite
docker container exec image mkdir /home/Encours
docker container exec image mkdir /home/Termine
mkdir ./ImageTraite 

#on recherche tout les fichiers image 
ficpng=$(ls *.png)
ficjpeg=$(ls *.jpg)
ficwebp=$(ls *.webp)
ficpdf=$(ls *.pdf)

#on envoi tout les fichiers dans le container
for fic in $ficpng $ficjpeg $ficpdf $ficwebp
do
    docker container cp ./$fic image:/home/Ntraite/$fic
    docker container exec -u root image chmod 666 /home/Ntraite/$fic
done

#on execute le script du container
docker container exec -u root image bash /home/deuxieme.bash

#on recupere toutes les images modifiés
fini=$(docker container exec image ls /home/Termine)


#on ramene toutes les images modifiés
for fic in $fini
do
    docker container cp image:/home/Termine/$fic ../ImageTraite
done

#on efface le docker a la fin du script
docker container stop image
docker container rm image