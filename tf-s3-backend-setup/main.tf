locals {
  region  = "us-east-1"
  profile = "localstack2"
}
provider "aws" {
  region  = local.region
  profile = local.profile


  # UNCOMMENT SECTION A if not using tflocal
  #   # section A: only required for non virtual hosted-style endpoint use case.
  #   # https://registry.terraform.io/providers/hashicorp/aws/latest/docs#s3_use_path_style
  #     s3_use_path_style           = true
  #     skip_credentials_validation = true
  #     skip_metadata_api_check     = true
  #     skip_requesting_account_id  = true
  #     s3_force_path_style         = true
  #     endpoints {
  #       dynamodb = "http://localhost:4566"
  #       s3       = "http://s3.localhost.localstack.cloud:4566"
  #     }
  #   #  note can skip adding section A if using tflocal
  #   #   end section A

}
resource "aws_s3_bucket" "terraform_state" {
  bucket = "tfstate-s3bucket"

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_encryption" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_acl" "terraform_state_acl" {
  bucket = aws_s3_bucket.terraform_state.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "terraform_state_access" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "tfstate-ddb"
  read_capacity  = 0
  write_capacity = 0
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
