terraform {
  required_version = ">= 1.14.3"
  backend "s3" {
    bucket = "odoo-infra-production-state"
    key    = "stage/services/terraform.tfstate"
    region = "us-east-1"
    endpoints = { s3 = "https://nbg1.your-objectstorage.com" } # Corrected Hostname
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true
  }
}

data "terraform_remote_state" "net" {
  backend = "s3"
  config = {
    bucket = "odoo-infra-production-state"
    key    = "stage/networking/terraform.tfstate"
    region = "us-east-1"
    endpoints = { s3 = "https://fsn1.your-objectstorage.com" }
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true
  }
}

module "odoo" {
  source        = "../../../modules/services/odoo-app"
  network_id    = data.terraform_remote_state.net.outputs.vpc_id
  firewall_id   = data.terraform_remote_state.net.outputs.firewall_id
  db_private_ip = "10.0.1.10"
}