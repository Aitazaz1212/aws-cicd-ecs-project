terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket"
    key    = "ecs/terraform.tfstate"
    region = "us-east-2"
  }
}
