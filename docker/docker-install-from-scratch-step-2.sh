#!/bin/bash
echo Get status of docker service
systemctl status docker
echo Test of docker installation
docker run hello-world
