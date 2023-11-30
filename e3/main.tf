resource "aws_vpc" "e3_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "e3-vpc"
  }
}

resource "aws_subnet" "e3_public_subnet" {
  vpc_id                  = aws_vpc.e3_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.ZONE1 # Change as needed
  map_public_ip_on_launch = true
  tags = {
    Name = "e3-public-subnet"
  }
}

resource "aws_subnet" "e3_private_subnet" {
  vpc_id            = aws_vpc.e3_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.ZONE2 # Change as needed
  tags = {
    Name = "e3-private-subnet"
  }
}

resource "aws_instance" "e3_bastion_host" {
  ami           = var.AMIS # Amazon Linux 2 AMI, change as needed
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.e3_public_subnet.id

  key_name = "terraform-new-key1" # Change as needed

  tags = {
    Name    = "e3-bastion-host"
    Project = "e3"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir /opt/ansible/inventory",
      "cd /opt/ansible/inventory",
      "touch aws_ec2.yaml"
    ]
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"                     # Replace with your EC2 user
    private_key = file("terraform-new-key1.pem") # Replace with the path to your private key
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "terraform-new-key1.pem"
    destination = "/opt/ansible/inventory/terraform-new-key1.pem"
  }
  provisioner "file" {
    source      = "pb1.yaml"
    destination = "/opt/ansible/inventory/pb1.yaml"
  }
  provisioner "file" {
    source      = "pb2.yaml"
    destination = "/opt/ansible/inventory/pb2.yaml"
  }
  provisioner "file" {
    source      = "pb3.yaml"
    destination = "/opt/ansible/inventory/pb3.yaml"
  }
  provisioner "file" {
    source      = "aws_ec2.yaml"
    destination = "/opt/ansible/inventory/aws_ec2.yaml"
  }
}

resource "aws_instance" "e3_web_server" {
  ami           = var.AMIS # Amazon Linux 2 AMI, change as needed
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.e3_public_subnet.id

  key_name = "terraform-new-key1" # Change as needed

  tags = {
    Name    = "web-server"
    Project = "e3"
  }
}

resource "aws_instance" "e3_backend_server_1" {
  ami           = var.AMIS # Amazon Linux 2 AMI, change as needed
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.e3_private_subnet.id

  key_name = "terraform-new-key1" # Change as needed
  tags = {
    Name    = "e3-redis"
    Project = "e3"
  }
}

resource "aws_instance" "e3_backend_server_2" {
  ami           = var.AMIS # Amazon Linux 2 AMI, change as needed
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.e3_private_subnet.id

  key_name = "terraform-new-key1" # Change as needed
  tags = {
    Name    = "e3-mysql"
    Project = "e3"
  }
}
