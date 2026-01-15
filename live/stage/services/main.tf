data "terraform_remote_state" "net" {
  backend = "s3"
  config = {
    bucket = "my-odoo-infra-state"
    key    = "stage/networking/terraform.tfstate"
    # ... (rest of S3 config)
  }
}

data "terraform_remote_state" "db" {
  backend = "s3"
  config = {
    bucket = "my-odoo-infra-state"
    key    = "stage/data-stores/terraform.tfstate"
    # ... (rest of S3 config)
  }
}

module "odoo" {
  source      = "../../../modules/services/odoo-app"
  network_id  = data.terraform_remote_state.net.outputs.vpc_id
  firewall_id = data.terraform_remote_state.net.outputs.firewall_id
  db_private_ip = "10.0.1.10"
}
