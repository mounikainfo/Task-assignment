# project details
region       = "us-west-2"
project_name = "task"
environment  = "dev"

# s3 variables
env_file_bucket_name = "<bucket name>"
env_file_name        = "<file name>"

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
ssh_ip = "<id>"

# rds variables
database_snapshot_identifier = "data"
database_instance_class      = "db.t2.micro"
database_instance_identifier = "data"
muti_az_deployment           = "false"


#acm variables
domain_name       = "<domain name>"
alternative_names = "*.<domain name>"

# alb variables
target_type = "ip"

# route-53 variables
record_name = "WWW"
