terraform {
  backend "s3" {
    endpoint = "nbg1.your-object-storage.com" # Hetzner S3 endpoint
    bucket   = "my-odoo-infra-state"
    key      = "stage/networking/terraform.tfstate"
    region   = "us-east-1" 
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
  }
}

module "vpc" {
  source           = "../../../modules/networking/hcloud-vpc"
  network_name     = "stage-odoo-vpc"
  developer_ssh_ip = "203.0.113.10/32"
}
