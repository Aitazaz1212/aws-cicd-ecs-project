module "vpc" {
  source = "./modules/vpc"
  project_name = var.project_name
}

module "ecr" {
  source     = "./modules/ecr"
  repo_name  = var.repo_name
}

module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
}

module "ecs" {
  source        = "./modules/ecs"
  project_name  = var.project_name
  app_port      = var.app_port
  cluster_role_arn = module.iam.ecs_task_execution_role_arn
  vpc_id        = module.vpc.vpc_id
  subnet_ids    = module.vpc.subnet_ids
  security_group_id = module.vpc.security_group_id
  repo_url      = module.ecr.repo_url
}

module "alb" {
  source        = "./modules/alb"
  project_name  = var.project_name
  vpc_id        = module.vpc.vpc_id
  subnet_ids    = module.vpc.subnet_ids
  ecs_service_arn = module.ecs.service_arn
  ecs_target_group_arn = module.ecs.target_group_arn
}
