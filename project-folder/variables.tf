# environment vatiables
variable "region" {}
variable "project_name" {}
variable "environment" {}


/* # s3 variables
variable "env_file_bucket_name" {}
variable "env_file_name" {} */


# s3 variables
variable "env_file_bucket_name" {}
variable "env_file_name" {}

# vpc variables
variable "vpc_cidr" {}
variable "public_subnet_az1_cidr" {}
variable "public_subnet_az2_cidr" {}
variable "private_app_subnet_az1_cidr" {}
variable "private_app_subnet_az2_cidr" {}
variable "private_data_subnet_az1_cidr" {}
variable "private_data_subnet_az2_cidr" {}

# security groups variables
variable "ssh_ip" {}