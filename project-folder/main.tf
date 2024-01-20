locals {
  region       = var.region
  project_name = var.project_name
  environment  = var.environment
}

# create s3 bucket
module "s3_bucket" {
  source               = "../modules/s3"
  project_name         = local.project_name
  env_file_bucket_name = var.env_file_bucket_name
  env_file_name        = var.env_file_name
}
