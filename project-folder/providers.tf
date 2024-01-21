# configure aws provider to establish a secure connection between terraform and aws
provider "aws" {
  region  = "us-west-2"
  profile = "mounika"

  default_tags {
    tags = {
      "Automation"  = "terraform"
      "Project"     = "task"
      "Environment" = "dev"
    }
  }
}

terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.23.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.5"
    }
    http = {
      source = "hashicorp/http"
      #version = "2.1.0"
      version = "~> 2.1"
    }
    # ingress-nginx = {
    #   source  = "ingress-nginx/ingress"
    #   version = "~> 1.2"  # Replace with the desired version
    # }
  }
}