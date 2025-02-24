resource "aws_vpc" "hublink_vpc" {
  enable_dns_hostnames = true
  cidr_block           = "10.0.0.0/16"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.hublink_vpc.id
}

// Subnets
resource "aws_subnet" "public_subnet_A" {
  vpc_id            = aws_vpc.hublink_vpc.id
  availability_zone = "${var.region}a"
  cidr_block        = "10.0.0.0/24"
}

resource "aws_subnet" "public_subnet_B" {
  vpc_id            = aws_vpc.hublink_vpc.id
  availability_zone = "${var.region}b"
  cidr_block        = "10.0.1.0/24"
}

resource "aws_subnet" "private_subnet_A" {
  vpc_id            = aws_vpc.hublink_vpc.id
  availability_zone = "${var.region}a"
  cidr_block        = "10.0.10.0/24"
}

resource "aws_subnet" "private_subnet_B" {
  vpc_id            = aws_vpc.hublink_vpc.id
  availability_zone = "${var.region}b"
  cidr_block        = "10.0.11.0/24"
}

// Route Tables
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.hublink_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.hublink_vpc.id
}

resource "aws_route_table_association" "public_route_A" {
  subnet_id      = aws_subnet.public_subnet_A.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_route_B" {
  subnet_id      = aws_subnet.public_subnet_B.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_route_A" {
  subnet_id      = aws_subnet.private_subnet_A.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_route_B" {
  subnet_id      = aws_subnet.private_subnet_B.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.hublink_vpc.id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.public_route_table.id,
    aws_route_table.private_route_table.id,
  ]

  tags = {
    Name      = "Hublink S3"
    terraform = true
  }
}
