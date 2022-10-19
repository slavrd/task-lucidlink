#!/bin/bash
# Sets up Nginx with SSL as reverse proxy for the Lucid daemon.

set -e

# Install Nginx
export DEBIAN_FRONTEND=noninteractive
apt-get update 
apt-get install -y nginx
systemctl enable nginx

# Remove the defualt Nginx site
[ -f /etc/nginx/sites-enabled/default ] && rm -f /etc/nginx/sites-enabled/default

# Setup HTTPS certificates
SSL_CERT_PATH='./assets/lucidssl.crt'
SSL_KEY_PATH='./assets/lucidssl.key'
cp $SSL_CERT_PATH /etc/ssl/certs/lucidssl.crt
cp $SSL_KEY_PATH /etc/ssl/private/lucidssl.key
# Make sure private key permissions are set correctly
chown root:root /etc/ssl/private/lucidssl.key
chmod 600 /etc/ssl/private/lucidssl.key

# Setup Nginx as reverse proxy for the Lucid service
NGINX_CONFIG_PATH='./assets/lucidapi.conf'
cp $NGINX_CONFIG_PATH /etc/nginx/sites-available/lucidapi.conf
ln -s /etc/nginx/sites-available/lucidapi.conf /etc/nginx/sites-enabled/lucidapi.conf
systemctl restart nginx

# Allow external access on port 443
ufw allow https
