terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.16"
    }
  }
  backend "s3" {
    bucket         = "microsvc-terraform-state"
    key            = "prod"
    region         = "eu-west-1"
    dynamodb_table = "microsvc-terraform-state"
  }
}
