terraform {
  backend "s3" {
    bucket    = "odoo-infra-production-state"
    key       = "stage/data-stores/terraform.tfstate"
    region    = "us-east-1"
    endpoints = { s3 = "https://fsn1.your-objectstorage.com" }
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
    bucket    = "odoo-infra-production-state"
    key       = "stage/networking/terraform.tfstate"
    region    = "us-east-1"
    endpoints = { s3 = "https://fsn1.your-objectstorage.com" }
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true
  }
}

module "postgres" {
  source     = "../../../modules/data-stores/postgres"
  network_id = data.terraform_remote_state.net.outputs.vpc_id
}
output "db_private_ip" {
  value       = module.postgres.db_private_ip
  description = "The private IP of the database for the Odoo service"
}