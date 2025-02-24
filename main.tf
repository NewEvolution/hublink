provider "aws" {
  region = var.region
  default_tags {
    tags = {
     Project = "hublink"
    }
  }
}

terraform {
  required_version = "> 0.15.0"
  backend "s3" {
    region = "CHANGEME"
    bucket = "CHANGEME"
    key    = "hublink.tfstate"
  }
}
