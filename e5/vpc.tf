resource "aws_vpc" "e3_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "e3-easy-vpc"
  }
}

resource "aws_subnet" "e3_public_subnet_1" {
  vpc_id                  = aws_vpc.e3_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.ZONE1 # Change as needed
  map_public_ip_on_launch = true
  tags = {
    Name = "e3-public-subnet-1"
  }
}

resource "aws_subnet" "e3_public_subnet_2" {
  vpc_id                  = aws_vpc.e3_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = var.ZONE2 # Change as needed
  map_public_ip_on_launch = true
  tags = {
    Name = "e3-public-subnet-2"
  }
}

resource "aws_subnet" "e3_private_subnet_1" {
  vpc_id            = aws_vpc.e3_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = var.ZONE1 # Change as needed
  tags = {
    Name = "e3-private-subnet-1"
  }
}

resource "aws_subnet" "e3_private_subnet_2" {
  vpc_id            = aws_vpc.e3_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = var.ZONE2 # Change as needed
  tags = {
    Name = "e3-private-subnet-2"
  }
}

resource "aws_internet_gateway" "e3_igw" {
  vpc_id = aws_vpc.e3_vpc.id
  tags = {
    Name = "e3-igw"
  }
}

resource "aws_route_table" "e3_public_route_table" {
  vpc_id = aws_vpc.e3_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.e3_igw.id
  }
  tags = {
    Name = "e3-public-route-table"
  }
}


resource "aws_route_table_association" "e3_public_subnet_1_association" {
  subnet_id      = aws_subnet.e3_public_subnet_1.id
  route_table_id = aws_route_table.e3_public_route_table.id
}

resource "aws_route_table_association" "e3_public_subnet_2_association" {
  subnet_id      = aws_subnet.e3_public_subnet_2.id
  route_table_id = aws_route_table.e3_public_route_table.id
}

resource "aws_eip" "e3_eip_natgw" {
  domain = "vpc"
}

resource "aws_nat_gateway" "e3_natgw" {
  allocation_id = aws_eip.e3_eip_natgw.id
  subnet_id     = aws_subnet.e3_public_subnet_1.id
  tags = {
    Name = "e3-nat-gateway"
  }
}

resource "aws_route_table" "e3_private_route_table_1" {
  vpc_id = aws_vpc.e3_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.e3_natgw.id
  }
  tags = {
    Name = "private-route-table-1"
  }
}

resource "aws_route_table_association" "e3_private_subnet_1_association" {
  subnet_id      = aws_subnet.e3_private_subnet_1.id
  route_table_id = aws_route_table.e3_private_route_table_1.id
}

resource "aws_route_table" "e3_private_route_table_2" {
  vpc_id = aws_vpc.e3_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.e3_natgw.id
  }
  tags = {
    Name = "private-route-table-2"
  }
}

resource "aws_route_table_association" "private_subnet_2_association" {
  subnet_id      = aws_subnet.e3_private_subnet_2.id
  route_table_id = aws_route_table.e3_private_route_table_2.id
}

