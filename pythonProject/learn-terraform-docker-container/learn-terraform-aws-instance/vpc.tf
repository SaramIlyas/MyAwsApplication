resource "aws_vpc" "vpc_1" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-1"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_1.id
}

# Create Route Table for public subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc_1.id

  tags = {
    Name = "Public Route Table"
  }
}

# Add Route to the Internet Gateway for the Route Table
resource "aws_route" "internet_gateway" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}