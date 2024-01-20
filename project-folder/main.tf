locals {
  region       = var.region
  project_name = var.project_name
  environment  = var.environment
}
/* 
# create s3 bucket
module "s3" {
  source      = "../modules/s3"
  name        = "private-terraform-module"
  environment = "prod"
}
 */

# create s3 bucket
module "s3_bucket" {
  source               = "../modules/s3"
  project_name         = local.project_name
  env_file_bucket_name = var.env_file_bucket_name
  env_file_name        = var.env_file_name
}

#vpc module

module "vpc" {
  source                       = "../modules/vpc"
  project_name                 = local.project_name
  environment                  = local.environment
  vpc_cidr                     = var.vpc_cidr
  public_subnet_az1_cidr       = var.public_subnet_az1_cidr
  public_subnet_az2_cidr       = var.public_subnet_az2_cidr
  private_app_subnet_az1_cidr  = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr  = var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr
}

# create nat gateways
module "nat_gateway" {
  source                     = "../modules/nat-gateway"
  project_name               = local.project_name
  environment                = local.environment
  public_subnet_az1_id       = module.vpc.public_subnet_az1_id
  internet_gateway           = module.vpc.internet_gateway
  public_subnet_az2_id       = module.vpc.public_subnet_az2_id
  vpc_id                     = module.vpc.vpc_id
  private_app_subnet_az1_id  = module.vpc.private_app_subnet_az1_id
  private_data_subnet_az1_id = module.vpc.private_data_subnet_az1_id
  private_app_subnet_az2_id  = module.vpc.private_app_subnet_az2_id
  private_data_subnet_az2_id = module.vpc.private_data_subnet_az2_id
}


# create security groups
module "security_group" {
  source       = "../modules/secutity-groups"
  project_name = local.project_name
  environment  = local.environment
  vpc_id       = module.vpc.vpc_id
  ssh_ip       = var.ssh_ip
}

# create iam
module "iam" {
  source       = "../modules/iam"
  project_name = local.project_name
  environment  = local.environment
}

# create EKS Cluster
module "eks" {
  source                    = "../modules/eks"
  project_name              = local.project_name
  environment               = local.environment
  EKS_CLUSTER_ROLE_ARN      = module.iam.EKS_CLUSTER_ROLE_ARN
  public_subnet_az1_id      = module.vpc.public_subnet_az1_id
  public_subnet_az2_id      = module.vpc.public_subnet_az2_id
  private_app_subnet_az1_id = module.vpc.private_app_subnet_az1_id
  private_app_subnet_az2_id = module.vpc.private_app_subnet_az2_id
}



# create Node Group
module "nodegroup" {
  source                    = "../modules/nodegroup"
  NODE_GROUP_ARN            = module.iam.NODE_GROUP_ROLE_ARN
  private_app_subnet_az1_id = module.vpc.private_app_subnet_az1_id
  private_app_subnet_az2_id = module.vpc.private_app_subnet_az2_id
  EKS_CLUSTER_NAME          = module.eks.EKS_CLUSTER_NAME
}