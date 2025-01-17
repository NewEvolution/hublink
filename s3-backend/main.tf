terraform {
  required_version = "> 0.15.0"
}

provider "aws" {
  region = "us-west-2"
  default_tags {
    tags = {
      Project = "hublink"
    }
  }
}

resource "aws_s3_bucket" "state" {
  bucket = "hublink-state-tf"

  tags = {
    Terraform = true
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.state.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "access" {
  bucket = aws_s3_bucket.state.id

  block_public_acls   = true
  block_public_policy = true
}
