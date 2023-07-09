
resource "aws_vpc" "zzttstack-vpc" {
  cidr_block           = var.Vpc_CIDR # attributes from documentation
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "zz-tt-stack-vpc"
  }
}

resource "aws_subnet" "zzttstack-pub-1" {
  vpc_id                  = aws_vpc.zzttstack-vpc.id # refer from vpc attributes
  cidr_block              = var.PubSub1CIDR
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "zz-tt-stack-pub-1"
  }
}

resource "aws_subnet" "zzttstack-pub-2" {
  vpc_id                  = aws_vpc.zzttstack-vpc.id # refer from vpc attributes
  cidr_block              = var.PubSub2CIDR
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2
  tags = {
    Name = "zz-tt-stack-pub-2"
  }
}

resource "aws_subnet" "zzttstack-pub-3" {
  vpc_id                  = aws_vpc.zzttstack-vpc.id # refer from vpc attributes
  cidr_block              = var.PubSub3CIDR
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE3
  tags = {
    Name = "zz-tt-stack-pub-3"
  }
}

resource "aws_subnet" "zzttstack-priv-1" {
  vpc_id                  = aws_vpc.zzttstack-vpc.id # refer from vpc attributes
  cidr_block              = var.PrivSub1CIDR
  map_public_ip_on_launch = "false"
  availability_zone       = var.ZONE1
  tags = {
    Name = "zz-tt-stack-priv-1"
  }
}

resource "aws_subnet" "zzttstack-priv-2" {
  vpc_id                  = aws_vpc.zzttstack-vpc.id # refer from vpc attributes
  cidr_block              = var.PrivSub2CIDR
  map_public_ip_on_launch = "false"
  availability_zone       = var.ZONE2
  tags = {
    Name = "zz-tt-stack-priv-2"
  }
}

resource "aws_subnet" "zzttstack-priv-3" {
  vpc_id                  = aws_vpc.zzttstack-vpc.id # refer from vpc attributes
  cidr_block              = var.PrivSub3CIDR
  map_public_ip_on_launch = "false"
  availability_zone       = var.ZONE3
  tags = {
    Name = "zz-tt-stack-priv-3"
  }
}



resource "aws_internet_gateway" "zzttstack-IGW" {
  vpc_id = aws_vpc.zzttstack-vpc.id # refer from vpc attributes

  tags = {
    Name = "zz-tt-stack-IGW"
  }
}

# create route table to join public subnet in Internet gateway
resource "aws_route_table" "zzttstack-pub-rt" {
  vpc_id = aws_vpc.zzttstack-vpc.id # refer from vpc attributes

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.zzttstack-IGW.id
  }

  tags = {
    Name = "zz-tt-stack-pub-rt"
  }
}

# route table association to associate pub subnet attach to this routetable
resource "aws_route_table_association" "zzttstack-pub-1-a" {
  subnet_id      = aws_subnet.zzttstack-pub-1.id
  route_table_id = aws_route_table.zzttstack-pub-rt.id
}
resource "aws_route_table_association" "zzttstack-pub-2-a" {
  subnet_id      = aws_subnet.zzttstack-pub-2.id
  route_table_id = aws_route_table.zzttstack-pub-rt.id
}
resource "aws_route_table_association" "zzttstack-pub-3-a" {
  subnet_id      = aws_subnet.zzttstack-pub-3.id
  route_table_id = aws_route_table.zzttstack-pub-rt.id
}
################################################
resource "aws_eip" "zzttstack-eip-natgw" {
  domain = "vpc"
}


resource "aws_nat_gateway" "zzttstack-NATGW" {
  allocation_id = aws_eip.zzttstack-eip-natgw.id
  subnet_id     = aws_subnet.zzttstack-pub-1.id

  tags = {
    Name = "zztt-NATgw"
  }
}



resource "aws_route_table" "zzttstack-pri-rt" {
  vpc_id = aws_vpc.zzttstack-vpc.id # refer from vpc attributes

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.zzttstack-NATGW.id
  }

  tags = {
    Name = "zz-tt-stack-pri-rt"
  }
}

# route table association to associate pub subnet attach to this routetable
resource "aws_route_table_association" "zzttstack-pri-1-a" {
  subnet_id      = aws_subnet.zzttstack-priv-1.id
  route_table_id = aws_route_table.zzttstack-pri-rt.id
}
resource "aws_route_table_association" "zzttstack-pri-2-a" {
  subnet_id      = aws_subnet.zzttstack-priv-2.id
  route_table_id = aws_route_table.zzttstack-pri-rt.id
}
resource "aws_route_table_association" "zzttstack-pri-3-a" {
  subnet_id      = aws_subnet.zzttstack-priv-3.id
  route_table_id = aws_route_table.zzttstack-pri-rt.id
}
