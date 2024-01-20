/* # store the terraform state file in s3 and lock with dynamodb
terraform {
  backend "s3" {
    bucket         = "task-ecs-env-file-bucket"
    key            = "backend/project-folder/terraform.tfstate"
    region         = "ap-south-1"
    profile        = "mounika"
    # dynamodb_table = "terraform-state-lock"
  }
}
  */