backend "s3" {
    bucket         = "microsvc-terraform"
    key            = "prod"
    region         = "eu-west-1"
    dynamodb_table = "microsvc-terraform"
  }
