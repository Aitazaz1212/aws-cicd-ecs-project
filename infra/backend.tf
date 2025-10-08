terraform {
  backend "s3" {
    bucket         = "my-terraform-backend-bucket"  # <-- REPLACE this with your S3 bucket
    key            = "aws-cicd-ecs-project/terraform.tfstate"
    region         = var.region
    dynamodb_table = "terraform-locks"               # create this table if you want locking
  }
}
