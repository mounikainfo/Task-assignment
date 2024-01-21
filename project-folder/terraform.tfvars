# project details
region       = "us-west-2"
project_name = "task"
environment  = "dev"

/* # s3 variables
env_file_bucket_name = "task-terraform-remote-state"
env_file_name        = "task.env" */



# s3 variables
env_file_bucket_name = "assignment-bucket"
env_file_name        = "rentzone.env"

# vpc variables
/* region                       = "us-west-2"
project_name                 = "rentzone"
environment                  = "dev" */ 
vpc_cidr                     = "10.0.0.0/16"
public_subnet_az1_cidr       = "10.0.0.0/24"
public_subnet_az2_cidr       = "10.0.1.0/24"
private_app_subnet_az1_cidr  = "10.0.2.0/24"
private_app_subnet_az2_cidr  = "10.0.3.0/24"
private_data_subnet_az1_cidr = "10.0.4.0/24"
private_data_subnet_az2_cidr = "10.0.5.0/24"

# security group variables
ssh_ip = "37.245.143.20/32"

