# from practice2, will use vars#
# based on practice 1, here take "provider" out by creating another .tf called "providers.tf" #
# create another vars.tf to define all variables #
# var.REGION
# var.AMIS[var.REGION], type = "map", useful for terraform script to diff region /
# then based on region to pick the right AMI ID




# define ec2 instance by vars
resource "aws_instance" "zz-tt-2" {
  ami                    = var.AMIS[var.REGION] # will based on default region "Sydney" to pick the AMI from vars.tf
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1 # from vars.tf
  key_name               = "zack2-ci-key"
  vpc_security_group_ids = ["sg-03465c5a5801a0e3f"]
  tags = {
    Name    = "zz-tt-2"
    Project = "zack-terraform"
  }
}
