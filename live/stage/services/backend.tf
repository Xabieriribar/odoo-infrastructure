terraform {
  backend "s3" {
    bucket   = "your-unique-bucket-name"
    key      = "stage/services/terraform.tfstate"
    region   = "nbg1" 
    endpoint = "https://nbg1.your-objectstorage.com"

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    force_path_style            = true
  }
}
