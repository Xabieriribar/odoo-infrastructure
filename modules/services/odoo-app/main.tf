terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

resource "hcloud_server" "odoo" {
  name        = "odoo-app-server"
  server_type = "cax21" # ARM
  image       = "ubuntu-22.04"
  firewall_ids = [var.firewall_id]

  network {
    network_id = var.network_id
  }

  user_data = templatefile("${path.module}/setup.sh", {
    db_host = var.db_private_ip
  })
}
