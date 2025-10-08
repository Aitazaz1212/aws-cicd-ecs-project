terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# 🧩 VPC
module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
}

# 🧩 ECR
module "ecr" {
  source    = "./modules/ecr"
  repo_name = var.repo_name
}

# 🧩 IAM (for GitHub OIDC)
module "iam" {
  source                   = "./modules/iam"
  project_name             = var.project_name
  github_oidc_provider_arn = var.github_oidc_provider_arn
  github_repo              = var.github_repo
  github_branch            = var.github_branch
}

# 🧩 ECS Cluster (EC2-based)
module "ecs" {
  source             = "./modules/ecs"
  project_name       = var.project_name
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.private_subnets
  security_group_id  = module.vpc.ecs_sg_id
  repo_url           = module.ecr.repo_url
  app_port           = var.app_port
}

# 🧩 EC2 Instance for ECS
module "ec2" {
  source             = "./modules/ec2"
  project_name       = var.project_name
  subnet_ids         = module.vpc.public_subnets
  security_group_id  = module.vpc.ecs_sg_id
  ecs_cluster_name   = module.ecs.cluster_name
  ec2_key_name       = var.ec2_key_name
  ec2_instance_type  = var.ec2_instance_type
}

# 🧩 ALB
module "alb" {
  source       = "./modules/alb"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  subnets      = module.vpc.public_subnets
  target_port  = var.app_port
}
