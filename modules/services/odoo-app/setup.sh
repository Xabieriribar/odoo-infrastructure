#!/bin/bash
set -e

# 1. Install Docker & Compose
apt-get update
apt-get install -y ca-certificates curl gnupg
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 2. Deploy Odoo 17
mkdir -p /opt/odoo
cat <<EOF > /opt/odoo/docker-compose.yml
services:
  odoo:
    image: odoo:17
    ports:
      - "80:8069"
    environment:
      - HOST=${db_host}
      - USER=odoo
      - PASSWORD=odoo
    restart: always
EOF

cd /opt/odoo && docker compose up -d