resource "aws_vpc" "zz-tt-6-vpc" {
  cidr_block           = "10.0.0.0/16" # attributes from documentation
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "zz-tt-6"
  }
}

resource "aws_subnet" "zz-tt-6-pub-1" {
  vpc_id                  = aws_vpc.zz-tt-6-vpc.id # refer from vpc attributes
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "zz-tt-6-pub-1"
  }
}

resource "aws_subnet" "zz-tt-6-pub-2" {
  vpc_id                  = aws_vpc.zz-tt-6-vpc.id # refer from vpc attributes
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2
  tags = {
    Name = "zz-tt-6-pub-2"
  }
}

resource "aws_subnet" "zz-tt-6-pub-3" {
  vpc_id                  = aws_vpc.zz-tt-6-vpc.id # refer from vpc attributes
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE3
  tags = {
    Name = "zz-tt-6-pub-3"
  }
}

resource "aws_subnet" "zz-tt-6-priv-1" {
  vpc_id                  = aws_vpc.zz-tt-6-vpc.id # refer from vpc attributes
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "zz-tt-6-priv-1"
  }
}

resource "aws_subnet" "zz-tt-6-priv-2" {
  vpc_id                  = aws_vpc.zz-tt-6-vpc.id # refer from vpc attributes
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2
  tags = {
    Name = "zz-tt-6-priv-2"
  }
}

resource "aws_subnet" "zz-tt-6-priv-3" {
  vpc_id                  = aws_vpc.zz-tt-6-vpc.id # refer from vpc attributes
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE3
  tags = {
    Name = "zz-tt-6-priv-3"
  }
}

resource "aws_internet_gateway" "zz-tt-6-IGW" {
  vpc_id = aws_vpc.zz-tt-6-vpc.id

  tags = {
    Name = "zz-tt-6-IGW"
  }
}

# create route table to join public subnet in Internet gateway
resource "aws_route_table" "zz-tt-6-pub-rt" {
  vpc_id = aws_vpc.zz-tt-6-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.zz-tt-6-IGW.id
  }

  tags = {
    Name = "zz-tt-6-pub-rt"
  }
}

# route table association to associate pub subnet attach to this routetable
resource "aws_route_table_association" "zz-tt-pub-1-a" {
  subnet_id      = aws_subnet.zz-tt-6-pub-1.id
  route_table_id = aws_route_table.zz-tt-6-pub-rt.id
}
resource "aws_route_table_association" "zz-tt-pub-2-a" {
  subnet_id      = aws_subnet.zz-tt-6-pub-2.id
  route_table_id = aws_route_table.zz-tt-6-pub-rt.id
}
resource "aws_route_table_association" "zz-tt-pub-3-a" {
  subnet_id      = aws_subnet.zz-tt-6-pub-3.id
  route_table_id = aws_route_table.zz-tt-6-pub-rt.id
}