variable "project_name" {
  type    = string
  default = "aws-cicd-ecs-project"
}

variable "app_port" {
  type    = number
  default = 3000
}

variable "cluster_role_arn" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "repo_url" {
  type = string
}
