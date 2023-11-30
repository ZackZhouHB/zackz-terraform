resource "aws_security_group" "elb-sg" {
  name        = "e9-sg-elb"
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

resource "aws_security_group" "elb-sg-2" {
  name        = "e9-sg-elb-2"
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

resource "aws_security_group" "e9_bastion_sg" {
  name        = "E9-bastion-sg"
  description = "security group for bastion host"
  vpc_id      = module.vpc.vpc_id # refer from vpc attributes

  ingress {
    protocol    = "tcp"
    cidr_blocks = [var.MY_IP]
    from_port   = 22
    to_port     = 22
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # means all protocol
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "e9-bean-sg" {
  name        = "e9-bean-sg"
  description = "security group for beanstalk instances"
  vpc_id      = module.vpc.vpc_id # refer from vpc attributes

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # means all protocol
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol        = "tcp"
    security_groups = [aws_security_group.e9_bastion_sg.id] # allow from bastion host SG, I can ssh to bastion host then from there ssh/
    # to beanstalk instances in private subnet and SG
    from_port = 22
    to_port   = 22
  }
}


resource "aws_security_group" "e9-bean-sg-2" {
  name        = "e9-bean-sg-2"
  description = "security group for beanstalk 2 instances"
  vpc_id      = module.vpc.vpc_id # refer from vpc attributes

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # means all protocol
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol        = "tcp"
    security_groups = [aws_security_group.e9_bastion_sg.id] # allow from bastion host SG, I can ssh to bastion host then from there ssh/
    # to beanstalk instances in private subnet and SG
    from_port = 22
    to_port   = 22
  }
}


