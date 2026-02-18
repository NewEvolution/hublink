resource "aws_security_group" "hublink_ec2_sg" {
  name        = "Hublink EC2 Security Group"
  description = "Allow SSH"
  vpc_id      = aws_vpc.hublink_vpc.id

  ingress {
    description = "Instance SSH access"
    from_port   = 7153
    to_port     = 7153
    protocol    = "tcp"
    cidr_blocks = ["${var.external_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
