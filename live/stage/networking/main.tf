terraform {
  required_version = ">= 1.14.3"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }

  backend "s3" {
    bucket    = "odoo-infra-production-state"
    key       = "stage/networking/terraform.tfstate"
    region    = "us-east-1"
    endpoints = { s3 = "https://fsn1.your-objectstorage.com" } # Updated endpoint

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true
  }
}

module "vpc" {
  source           = "../../../modules/networking/hcloud-vpc"
  network_name     = "stage-odoo-vpc"
  developer_ssh_ip = "185.25.195.181/32" # Make sure to replace this!
}
output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC for the data-stores layer"
}

output "firewall_id" {
  value       = module.vpc.firewall_id
  description = "The ID of the Firewall for the services layer"
}