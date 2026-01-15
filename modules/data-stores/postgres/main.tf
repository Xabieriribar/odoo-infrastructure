terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

resource "hcloud_server" "db" {
  name        = "postgres-db"
  server_type = "cax21"
  image       = "ubuntu-22.04"
  location    = "nbg1"

  network {
    network_id = var.network_id
    ip         = "10.0.1.10"
  }
  
  public_net {
    ipv4_enabled = false
    ipv6_enabled = false
  }
}

resource "hcloud_volume" "postgres_data" {
  name      = "postgres-volume"
  size      = 50
  server_id = hcloud_server.db.id
  automount = true
}