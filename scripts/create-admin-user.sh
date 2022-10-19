#!/bin/bash
# Creates admin user.
# Set options via the variables below
# USER_LOGIN - set the login for the user. Default: lucidadmin
# USER_PASS - set the user password. Default: none
# PUB_KEY_PATH - path to the publick SSH key for the user. Default: ./assets/sshkey.pub

set -e

# Createa User
[ -z "${USER_LOGIN}" ] && USER_LOGIN='lucidadmin'
useradd -U -G sudo -m -s /usr/bin/bash $USER_LOGIN

[ -z "$USER_PASS" ] || echo "${USER_LOGIN}:${USER_PASS}" | chpasswd $USER_LOGIN

# Setup authorized ssh key
mkdir /home/$USER_LOGIN/.ssh
chmod 700 /home/$USER_LOGIN/.ssh

# Place the public SSH key in /home/lucidadmin/.ssh/authorized_keys
[ -z "${PUB_KEY_PATH}" ] && PUB_KEY_PATH='./assets/sshkey.pub'
cp $PUB_KEY_PATH /home/$USER_LOGIN/.ssh/authorized_keys
chmod 600 /home/$USER_LOGIN/.ssh/authorized_keys
chown -R $USER_LOGIN:$USER_LOGIN /home/$USER_LOGIN/.ssh
