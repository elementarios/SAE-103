#!/usr/bin/bash
docker run -dit --name image sae103-imagick  #changer  en bigpapoo/sae103-imagick si vous n'etes pas a l'iut
docker container cp ./traitement_image/deuxieme.bash image:/home
docker container exec image mkdir /home/Ntraite
docker container exec image mkdir /home/Termine
mkdir ./ImageTraite

ficpng=ls ./*.png
ficjpeg=ls ./*.jpg
ficwebp=ls ./*.webp

for $fic1 in $ficpng
do
    docker container cp ../$fic1 image:/home/Ntraite/$fic1
done

for $fic2 in $ficjpeg
do
    docker container cp ../$fic2 image:/home/Ntraite/$fic2
done

for $fic3 in $ficwebp
do
    docker container cp ../$fic3 image:/home/Ntraite/$fic3
done

docker container exec image bash /home/deuxieme.bash


fini=$(docker container exec image ls /home/Termine)


for $fic in $fini
do
    docker container cp image:/home/Termine/$fic ../ImageTraite
done

docker container stop image
docker container rm image