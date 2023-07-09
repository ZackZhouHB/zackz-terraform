resource "aws_security_group" "zztt-stack-beanelbsg" {
  name        = "zz-tt-stack-bean-elb-sg"
  description = "security group for beanstalk elb"
  vpc_id                  = aws_vpc.zzttstack-vpc.id # refer from vpc attributes

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # means all protocol
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # allow from anywhere to beanstalk elb
    from_port   = 80
    to_port     = 80
  }
}

resource "aws_security_group" "zztt-stack-bastionsg" {
  name        = "zz-tt-stack-bastion-sg"
  description = "security group for bastion host"
  vpc_id                  = aws_vpc.zzttstack-vpc.id # refer from vpc attributes

  ingress {
    protocol    = "tcp"
    cidr_blocks = [var.MYIP]
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

resource "aws_security_group" "zztt-stack-bean-sg" {
  name        = "zz-tt-stack-bean-sg"
  description = "security group for beanstalk instances"
  vpc_id                  = aws_vpc.zzttstack-vpc.id # refer from vpc attributes

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # means all protocol
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol        = "tcp"
    security_groups = [aws_security_group.zztt-stack-bastionsg.id] # allow from bastion host SG, I can ssh to bastion host then from there ssh/
    # to beanstalk instances in private subnet and SG
    from_port = 22
    to_port   = 22
  }
}

resource "aws_security_group" "zztt-stack-backend-sg" {
  name        = "zz-tt-stack-backend-sg"
  description = "security group for backend instances, RDS, active MQ, Elastic cache"
  vpc_id                  = aws_vpc.zzttstack-vpc.id # refer from vpc attributes

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # means all protocol
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol        = "-1"                                       # allow all protocol, so beanstalk can access to backend service 
    security_groups = [aws_security_group.zztt-stack-bean-sg.id] # allow from beanstalk instances SG, /
    # so beanstalk can talk to backend services
    from_port = 0
    to_port   = 0
  }

  ingress {
    protocol        = "tcp"
    security_groups = [aws_security_group.zztt-stack-bastionsg.id] # allow bastion to access rds for db initialization
    from_port       = 3306
    to_port         = 3306
  }
}

# for allow RDS, active MQ, Elastic cache talk to each other
resource "aws_security_group_rule" "sg_allow_itself" { # update add sg rules
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535 # all ports
  protocol                 = "tcp"
  security_group_id        = aws_security_group.zztt-stack-backend-sg.id
  source_security_group_id = aws_security_group.zztt-stack-backend-sg.id # (same sg)
}