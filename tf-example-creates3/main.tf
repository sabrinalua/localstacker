locals {
  region = "us-east-1"
}

provider "aws" {

  region  = "us-east-1"
  profile = "localstack2"

  # only required for non virtual hosted-style endpoint use case.
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs#s3_use_path_style
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_force_path_style         = true

  assume_role {

  }
  # point to localstack 
  endpoints {
    apigateway     = "http://localhost:4566"
    apigatewayv2   = "http://localhost:4566"
    cloudformation = "http://localhost:4566"
    cloudwatch     = "http://localhost:4566"
    cloudwatchlogs = "http://localhost:4566"
    dynamodb       = "http://localhost:4566"
    ec2            = "http://localhost:4566"
    es             = "http://localhost:4566"
    elasticache    = "http://localhost:4566"
    firehose       = "http://localhost:4566"
    iam            = "http://localhost:4566"
    kinesis        = "http://localhost:4566"
    lambda         = "http://localhost:4566"
    rds            = "http://localhost:4566"
    redshift       = "http://localhost:4566"
    route53        = "http://localhost:4566"
    s3             = "http://s3.localhost.localstack.cloud:4566"
    secretsmanager = "http://localhost:4566"
    ses            = "http://localhost:4566"
    sns            = "http://localhost:4566"
    sqs            = "http://localhost:4566"
    ssm            = "http://localhost:4566"
    stepfunctions  = "http://localhost:4566"
    sts            = "http://localhost:4566"
  }
}

terraform {
  backend "s3" {
    bucket                      = "tfstate-s3bucket"
    key                         = "main2/terraform.tfstate"
    region                      = "us-east-1"
    endpoint                    = "http://localhost:4566"
    skip_credentials_validation = true # workaround for localstack
    skip_metadata_api_check     = true
    force_path_style            = true
    dynamodb_table              = "tfstate-ddb"
    dynamodb_endpoint           = "http://localhost:4566"
    encrypt                     = true
  }
}

# # uncomment after first successful terraform apply
data "terraform_remote_state" "dev_env_state" {
  backend = "s3"
  #   workspace = terraform.workspace

  config = {
    bucket                      = "tfstate-s3bucket"
    key                         = "main2/terraform.tfstate"
    region                      = "us-east-1"
    endpoint                    = "http://localhost:4566"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
    dynamodb_table              = "tfstate-ddb"
    dynamodb_endpoint           = "http://localhost:4566"
    encrypt                     = true

  }
}


resource "aws_s3_bucket" "test-bucket" {
  bucket = "my-bucket-jaa"
}
