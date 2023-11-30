resource "aws_instance" "aws_instance_NM_e4" {
  ami                    = var.AMIS
  key_name               = "terraform-new-key1"
  availability_zone      = var.ZONE1
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-0861a6efb1ea9ba42"]
  tags = {
    Name    = "T-N-T-e4"
    Project = "new-t-e4"
  }
}