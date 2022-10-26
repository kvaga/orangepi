#!/bin/bash
sudo systemctl stop docker.transmission.service
sudo systemctl disable docker.transmission.service
sudo cp docker.transmission.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl start docker.transmission.service
sudo systemctl enable docker.transmission.service
sudo systemctl status docker.transmission.service
