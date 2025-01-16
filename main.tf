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
  backend "s3" {
    bucket = "hublink-state-tf"
    key    = "hublink.tfstate"
    region = "us-east-1"
  }
}
