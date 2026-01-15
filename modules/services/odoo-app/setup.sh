#!/bin/bash
set -e

# Update and install Docker
apt-get update
apt-get install -y ca-certificates curl gnupg
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Create directory for Odoo
mkdir -p /opt/odoo
cd /opt/odoo

# Generate a simple docker-compose for Odoo 17 (ARM Compatible)
cat <<EOF > docker-compose.yml
services:
  web:
    image: odoo:17
    depends_on:
      - db
    ports:
      - "8069:8069"
    environment:
      - HOST=${db_host}
      - USER=odoo
      - PASSWORD=odoo
EOF

docker compose up -d