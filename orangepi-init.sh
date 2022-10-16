#!/bin/bash
source lib.sh

log "Update system dependencies..."
sudo apt update

log "Upgrade system"
sudo apt upgrade

log "The list of possible timezones"
sudo timedatectl list-timezones | grep -i moscow
log "Set your timezone"
echo "Enter timezone:"
read timezone
sudo timedatectl set-timezone $timezone
sudo timedatectl status

log "Set static hostname"
echo "Enter a hostname:"
read host_name
sudo hostnamectl set-hostname $host_name –-static
