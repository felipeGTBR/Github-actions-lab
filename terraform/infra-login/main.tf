terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.54.0"
    }
  }
  #   backend "s3" {
  #    bucket = "remote-backend-login-prefeitura-digital"
  #    key    = "remote-backend/terraform.tfstate"
  #    region = "us-east-1"
  #    dynamodb_table = "remote-backend-login-prefeitura-digital"
  #  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = var.tags
  }
}