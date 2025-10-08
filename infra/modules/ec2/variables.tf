variable "project_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "ecs_cluster_name" {
  type = string
}

variable "ec2_key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "ec2_instance_type" {
  description = "EC2 instance type for ECS host"
  type        = string
  default     = "t3.micro"
}
