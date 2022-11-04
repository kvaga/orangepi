#!/bin/bash
source ../../../lib.sh

log "Stopping..."
docker-compose down
log "Starting..."
docker-compose up -d
log "Status"
docker ps -a | grep nginx
log "Getting logs"
docker logs --follow nginx_web_1

