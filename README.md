# docker-volume-container
Repository für building a docker container with nginx, uwsgi and python to host a flask webapp. 

This repository uses an alpine linux image and flask (python), which ends up in an image with about 330MB in size. Without flask and python you could possibly shrink the image size by A LOT. Since I wanted a flask webapp tho I had to include flask (and thus python) for a personal project I was working on.

UWSGI has the main.py configured as main module. There it tries to start 'app' - thus the flask app instance. 