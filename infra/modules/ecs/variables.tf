variable "project_name" {}
variable "app_port" {}
variable "cluster_role_arn" {}
variable "vpc_id" {}
variable "subnet_ids" { type = list(string) }
variable "security_group_id" {}
variable "repo_url" {}
variable "target_group_arn" {}
