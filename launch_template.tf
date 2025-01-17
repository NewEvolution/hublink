data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["arm64"]
  }

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
}

data "aws_default_tags" "default_tags" {}

locals {
  resources_to_tag = ["instance", "volume", "network-interface"]
}

resource "aws_launch_template" "hublink_ec2_lt" {
  name_prefix                          = "hublink-lt-"
  ebs_optimized                        = true
  image_id                             = data.aws_ami.al2023.id
  instance_type                        = "t4g.micro"
  key_name                             = "Abomination"
  instance_initiated_shutdown_behavior = "terminate"
  subnet_id                            = aws_subnet.public_subnet_B.id

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.hublink_ec2_sg.id]
  }

  dynamic "tag_specifications" {
    for_each = {
      for type in local.resources_to_tag : type => data.aws_default_tags.default_tags
    }
    content {
      resource_type = tag_specifications.key
      tags = merge(
        tag_specifications.value.tags,
        {
          "Name"    = "Hublink"
        }
      )
    }
  }
}
