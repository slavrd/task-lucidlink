#!/bin/bash
# Secures the VM by configuring SSH and setting up firewall - UFW.

set -e

# Setup SSH
SSH_CONFIG_PATH='./assets/sshd_config'

rm -f /etc/ssh/sshd_config.d/*
cp $SSH_CONFIG_PATH /etc/ssh/sshd_config
systemctl reload sshd

# Enable UFW
ufw allow OpenSSH
ufw --force enable
