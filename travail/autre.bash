#!/usr/bin/bash
docker container cp ./test.bash me:/home
docker container exec me /home/test.bash