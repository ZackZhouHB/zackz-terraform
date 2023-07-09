resource "aws_vpc" "mainvpc" {
  cidr_block = "10.1.0.0/16"
}

resource "aws_security_group" "zz-tt-stack-sg" {
  vpc_id      = aws_vpc.zz-tt-6-vpc.id
  name        = "zz-tt-stack-sg"
  description = "zz-tt-sg for stack"
  ingress {
    protocol    = "tcp"
    cidr_blocks = [var.MYIP]
    from_port   = 22
    to_port     = 22
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = [var.MYIP]
    from_port   = 80
    to_port     = 80
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow ssh"
  }
}