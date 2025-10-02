output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}

output "repo_url" {
  value = module.ecr.repo_url
}

output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}
