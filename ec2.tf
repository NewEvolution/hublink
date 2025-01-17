resource "aws_instance" "ec2" {
  launch_template {
    id      = aws_launch_template.hublink_ec2_lt.id
    version = "$Latest"
  }

  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = 0.0036
    }
  }
}
