variable "project_name" {
  type    = string
  default = "aws-cicd-ecs-project"
}

variable "github_oidc_provider_arn" {
  type    = string
  default = ""   # set this to your provider ARN if you created it in the console/terraform
}

variable "github_repo" {
  type    = string
  default = "Aitazaz1212/aws-cicd-ecs-project"
}

variable "github_branch" {
  type    = string
  default = "main"
}
