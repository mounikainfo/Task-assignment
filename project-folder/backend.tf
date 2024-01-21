# store the terraform state file in s3 and lock with dynamodb
terraform {
  backend "s3" {
    bucket         = "uae-task-bucket"
    key            = "backend/project-folder/terraform.tfstate"
    region         = "us-west-2"
    profile        = "mounika"
    # dynamodb_table = "terraform-state-lock"
  }
}
