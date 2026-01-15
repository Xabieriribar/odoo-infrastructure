terraform {
  required_version = ">= 1.14.3"

  backend "s3" {
    bucket = "my-odoo-infra-state"
    key    = "stage/networking/terraform.tfstate"
    region = "us-east-1" # Dummy region for S3 compatibility
    
    endpoints = {
      s3 = "https://nbg1.your-object-storage.com" # Use your actual endpoint
    }

    # MANDATORY: Disable AWS-specific identity lookups
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true  # Prevents the STS:GetCallerIdentity error
    
    use_path_style              = true # Recommended for Hetzner/S3-compatible
  }
}

module "vpc" {
  source           = "../../../modules/networking/hcloud-vpc"
  network_name     = "stage-odoo-vpc"
  developer_ssh_ip = "YOUR_PC_IP/32" 
}