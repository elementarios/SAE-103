#!/usr/bin/bash
docker container run --rm -d --name image sae103-imagick tail -f /dev/null #changer  en bigpapoo/sae103-imagick si vous n'etes pas a l'iut
docker container cp ./deuxieme.bash image:/home
docker container exec image mkdir /home/Ntraite
docker container exec image mkdir /home/Termine
mkdir ../ImageTraite

for $fic in ../*.jpeg
do
    docker container cp ../$fic image:/home/Ntraite/$fic
done

for $fic in ../*.png
do
    docker container cp ../$fic image:/home/Ntraite/$fic
done

for $fic in ../*.webp
do
    docker container cp ../$fic image:/home/Ntraite/$fic
done

docker container exec bash image:/home/deuxieme.bash


fini=$(docker container exec image ls /home/Termine)


for $fic in $fini
do
    docker container cp image:/home/Termine/$fic ../ImageTraite
done

docker container stop image