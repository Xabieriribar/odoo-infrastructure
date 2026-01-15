data "terraform_remote_state" "net" {
  backend = "s3"
  config = {
    endpoint = "nbg1.your-object-storage.com"
    bucket   = "odoo-infra-production-state"
    key      = "stage/networking/terraform.tfstate"
  }
}

module "postgres" {
  source     = "../../../modules/data-stores/postgres"
  network_id = data.terraform_remote_state.net.outputs.vpc_id
}
