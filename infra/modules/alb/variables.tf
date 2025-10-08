variable "project_name" {
  type    = string
  default = "aws-cicd-ecs-project"
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "ecs_target_group_arn" {
  type = string
}
