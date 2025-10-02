variable "project_name" {}
variable "vpc_id" {}
variable "subnet_ids" { type = list(string) }
variable "app_port" {}
variable "security_group_id" {}
