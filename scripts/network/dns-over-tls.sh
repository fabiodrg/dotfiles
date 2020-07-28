#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "Please, run as root!"
  exit
fi

# Copy resolved.conf
cp resolved.conf /etc/systemd/resolved.conf && \
# Enable and restart systemd-resolved (if not running, start it)
systemctl enable systemd-resolved && \
systemctl restart systemd-resolved && \
# Restart NetworkManager
systemctl restart NetworkManager 