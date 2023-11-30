provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "aws_instance_NM" {
  ami                    = "ami-0f5f922f781854672"
  key_name               = "terraform-new-key1"
  availability_zone      = "ap-southeast-2a"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-0861a6efb1ea9ba42"]
  tags = {
    Name = "T-N-T"
    Project = "new-t-e1"
  }
}