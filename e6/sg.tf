resource "aws_security_group" "elb-test" {
  name        = "e6-sg-elb"
  description = "Allow elb inbound traffic"
  vpc_id      = module.vpc.vpc_id
  ingress {
    description = "elb from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


resource "aws_security_group" "bastion-test" {
  name        = "e6-sg-bastion"
  description = "Allow ebastion inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "22 from myip"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.MY_IP]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "backend-test" {
  name        = "e6-sg-backend"
  description = "Allow inbound traffic only from bastion SG"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "22 from bastion SG"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion-test.id]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
