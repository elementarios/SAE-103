#!/usr/bin/bash
docker container run -d --name me html2pdf tail -f /dev/null
docker container cp ./test.bash me:/home
docker container exec me bash /home/test.bash
docker container cp me:/home/dossier/test.txt ./
docker container stop me
docker container rm me