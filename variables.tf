variable "max_spot_price" {
  description = "Maximum spot instance price to accept"
  type        = number
}

variable "ssh_key_name" {
  description = "Name for the SSH key for connecting to the instance in AWS"
  type        = string
}

variable "ssh_public_key" {
  description = "Contents of the SSH public key"
  type        = string
}

variable "external_ip" {
  description = "Your public IP for allowing SSH connections"
  type        = string
}

variable "region" {
  description = "AWS region for infrastructure"
  type        = string
}

variable "state_bucket" {
  description = "Name of the S3 bucket that stores Terraform state."
  type        = string
}
