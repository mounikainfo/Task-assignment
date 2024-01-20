# store the terraform state file in s3 and lock with dynamodb
terraform {
  backend "s3" {
    bucket         = "task-terraform-remote-state"
    key            = "terraform-module/task/terraform.tfstate"
    region         = "ap-south-1"
    profile        = "mounika"
    dynamodb_table = "terraform-state-lock"
  }
}