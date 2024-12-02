# Define Subnets
resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.vpc_1.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "subnet-1"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.vpc_1.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "subnet-2"
  }
}

resource "aws_subnet" "subnet_3" {
  vpc_id            = aws_vpc.vpc_1.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-west-2c"

  tags = {
    Name = "subnet-3"
  }
}
# Public Route Table Association for Subnets
resource "aws_route_table_association" "subnet_1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "subnet_2" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "subnet_3" {
  subnet_id      = aws_subnet.subnet_3.id
  route_table_id = aws_route_table.public_route_table.id
}