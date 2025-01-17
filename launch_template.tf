data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-ecs-hvm-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon", "self"]
}

data "aws_default_tags" "default_tags" {}

locals {
  asg_resources_to_tag = ["instance", "volume", "network-interface"]
}

resource "aws_launch_template" "hublink_ec2_lt" {
  name_prefix                          = "hublink-lt-"
  ebs_optimized                        = true
  image_id                             = data.aws_ami.amazon_linux.id
  instance_type                        = "t4g.micro"
  key_name                             = "Abomination"
  instance_initiated_shutdown_behavior = "stop"

  iam_instance_profile {
    name = aws_iam_instance_profile.hublink_ecs_service_role.name
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.hublink_ec2_sg.id]
  }

  dynamic "tag_specifications" {
    for_each = {
      for type in local.asg_resources_to_tag : type => data.aws_default_tags.default_tags
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
