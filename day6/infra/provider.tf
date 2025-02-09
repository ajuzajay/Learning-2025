# terraform version
# aws plugin
# random provider
# terraform template

terraform {
  required_version = "1.8.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.50"
    }
    random = {
      source  = "hashicorp/random"
      version = "2.2.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# using s3 bucket to store terraform state file

terraform {
  backend "s3" {
    bucket = "816069150653-terraform-statefile"
    key    = "ecs-fargate/terraform.devtfstate"
    region = "us-east-1"
  }
}


