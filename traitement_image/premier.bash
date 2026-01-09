#!/usr/bin/bash
docker run -dit --name image sae103-imagick  #changer  en bigpapoo/sae103-imagick si vous n'etes pas a l'iut
docker container cp ./traitement_image/deuxieme.bash image:/home
docker container exec image mkdir /home/Ntraite
docker container exec image mkdir /home/Termine
mkdir ./ImageTraite

ficpng=$(ls *.png)
ficjpeg=$(ls *.jpg)
ficwebp=$(ls *.webp)
ficpdf=$(ls *.pdf)

for fic in $ficpng
do
    chmod +r $fic
    docker container cp ./$fic image:/home/Ntraite/$fic
done

for fic in $ficjpeg
do
    docker container cp ./$fic image:/home/Ntraite/$fic
done

for fic in $ficwebp
do
    docker container cp ./$fic image:/home/Ntraite/$fic
done

for fic in $ficpdf
do
    docker container cp ./$fic image:/home/Ntraite/$fic
done

docker container exec image bash /home/deuxieme.bash


fini=$(docker container exec image ls /home/Termine)


for fic in $fini
do
    docker container cp image:/home/Termine/$fic ../ImageTraite
done

docker container stop image
docker container rm image