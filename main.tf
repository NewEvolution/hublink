provider "aws" {
  region = "us-west-2"
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
    region = "us-west-2"
  }
}
