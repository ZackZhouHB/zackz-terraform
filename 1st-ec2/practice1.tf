# create a ec2, but need prepare a SG, key pair, aws configure before #
provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "zz-tt-ec2instance" {
  ami                    = "ami-0d6294dcaac5546e4"
  instance_type          = "t2.micro"
  availability_zone      = "ap-southeast-2a"
  subnet_id              = "subnet-094213c92c8978f49"
  key_name               = "zack2-ci-key"
  vpc_security_group_ids = ["sg-03465c5a5801a0e3f"]
  tags = {
    Name = "zz-tt"
  }
}