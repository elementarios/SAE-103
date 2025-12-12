#!/usr/bin/bash
docker container run --rm -d --name image sae103-imagick tail -f /dev/null
docker container cp ./deuxieme.bash image:/home
docker container exec image mkdir /home/Ntraite
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