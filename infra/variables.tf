variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "repo_name" {
  type    = string
  default = "ecs-app-repo"
}

variable "project_name" {
  type    = string
  default = "aws-cicd-ecs-project"
}

variable "app_port" {
  type    = number
  default = 3000
}

# For optional EC2 module
variable "ec2_key_name" {
  type    = string
  default = "terraform-key"
}

variable "ec2_instance_type" {
  type    = string
  default = "t3.micro"
}

# GitHub OIDC variables used by IAM module
variable "github_oidc_provider_arn" {
  type    = string
  default = "arn:aws:iam::706331681028:oidc-provider/token.actions.githubusercontent.com"
}


variable "github_repo" {
  description = "GitHub repo in form owner/repo (used in trust policy 'sub' condition)."
  type        = string
  default     = "Aitazaz1212/aws-cicd-ecs-project"
}

variable "github_branch" {
  description = "Branch name allowed to assume GitHub role"
  type        = string
  default     = "main"
}
