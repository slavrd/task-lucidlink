#!/bin/bash
# Sets up the Lucid client as service
# Need to provide the username and password as variables
# LUCID_USER
# LUCID_USER_PASS

set -e

# Check if variables are provided
[ -z "${LUCID_PASS}" ] && { 
    echo "LUCID_PASS was not set."
    exit 1
}

# set password
echo -n $LUCID_PASS > /root/.lucidpass
chown root:root /root/.lucidpass
chmod 600 /root/.lucidpass

# setup Lucid service
LUCID_SVC_UNIT_PATH='./assets/lucid.service'
LUCID_SVC_NAME='lucid.service'
cp $LUCID_SVC_UNIT_PATH /etc/systemd/system/$LUCID_SVC_NAME
systemctl daemon-reload
systemctl enable $LUCID_SVC_NAME
systemctl start $LUCID_SVC_NAME
