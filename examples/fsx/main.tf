provider "aws" {
  region = var.region
}

module "fsx-windows" {
  source  = "../../"

  contact     = var.contact
  environment = var.environment
  team        = var.team
  purpose     = var.purpose

  automatic_backup_retention_days = 7
  deployment_type                 = "SINGLE_AZ_2"
  managed_ad_fqdn                 = "corp.example.com"
  managed_ad_id                   = "d-123456789"
  storage_capacity                = 32
  storage_type                    = "SSD"
  subnet_ids                      = ["subnet-042ae28fd2a670ad9"]
  throughput_capacity             = 16
  vpc_id                          = "vpc-0e2008881bf9def09"
}