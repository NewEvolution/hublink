variable "region" {
  description = "AWS region for infrastructure"
  type        = string
}

variable "state_bucket" {
  description = "Name of the S3 bucket that stores Terraform state."
  type        = string
}
