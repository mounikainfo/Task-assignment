locals {
  region       = var.region
  project_name = var.project_name
  environment  = var.environment
}
/* 


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

# launch rds instance
module "rds" {
  source                       = "../modules/rds"
  project_name                 = local.project_name
  environment                  = local.environment
  private_data_subnet_az1_id   = module.vpc.private_data_subnet_az1_id
  private_data_subnet_az2_id   = module.vpc.private_data_subnet_az2_id
  database_snapshot_identifier = var.database_snapshot_identifier
  database_instance_class      = var.database_instance_class
  availability_zone_1          = module.vpc.availability_zone_1
  database_instance_identifier = var.database_instance_identifier
  muti_az_deployment           = var.muti_az_deployment
  database_security_group_id   = module.security_group.database_security_group_id
}


# request ssl certificate
module "ssl_certificate" {
  source            = "git@github.com:mounikainfo/terraform-modules.git//acm"
  domain_name       = var.domain_name
  alternative_names = var.alternative_names
}

# create application load balancer
module "application_load_balancer" {
  source                = "../modules/alb"
  project_name          = local.project_name
  environment           = local.environment
  alb_security_group_id = module.security_group.alb_security_group_id
  public_subnet_az1_id  = module.vpc.public_subnet_az1_id
  public_subnet_az2_id  = module.vpc.public_subnet_az2_id
  target_type           = var.target_type
  vpc_id                = module.vpc.vpc_id
  certificate_arn       = module.ssl_certificate.certificate_arn
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
  public_subnet_az1_id = module.vpc.public_subnet_az1_id
  public_subnet_az2_id = module.vpc.public_subnet_az2_id
  EKS_CLUSTER_NAME          = module.eks.EKS_CLUSTER_NAME
}


 # create records in route53
module "route_53" {
  source                             = "../modules/route-53"
  domain_name                        = module.ssl_certificate.domain_name
  record_name                        = var.record_name
  application_load_balancer_dns_name = module.application_load_balancer.application_load_balancer_dns_name
  application_load_balancer_zone_id  = module.application_load_balancer.application_load_balancer_zone_id
}
# print the website url
output "website_url" {
  value = join("", ["https://", var.record_name, ".", var.domain_name])
}