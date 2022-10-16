#!/bin/bash
source ../lib.sh
log "Create docker service"
sudo systemctl enable docker.service
log "Get status of docker service"
systemctl status docker
log "Test of docker installation"
docker run hello-world

