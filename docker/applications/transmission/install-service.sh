#!/bin/bash
sudo cp docker.transmission.service /etc/systemd/system
sudo systemctl stop docker.transmission.service
sudo systemctl daemon-reload
sudo systemctl enable docker.transmission.service
sudo systemctl start docker.transmission.service
sudo systemctl status docker.transmission.service
