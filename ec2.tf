resource "aws_instance" "ec2" {
  launch_template {
    id      = aws_launch_template.hublink_ec2_lt.id
    version = "$Latest"
  }

  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = var.max_spot_price
    }
  }
}

output "instance_id" {
  value = aws_instance.ec2.id
}
