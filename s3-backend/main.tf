provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Project = "hublink"
    }
  }
}

terraform {
  required_version = "> 0.15.0"
}

resource "aws_s3_bucket" "state" {
  bucket = "hublink-state-tf"
  acl    = "private"
  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = {
    Terraform = true
  }
}

resource "aws_s3_bucket_public_access_block" "nonpublic" {
  bucket = aws_s3_bucket.state.id

  block_public_acls   = true
  block_public_policy = true
}
