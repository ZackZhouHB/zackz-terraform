# Step 1: Create an EC2 instance with user data
resource "aws_instance" "e9_bastion" {
  ami             = var.AMIS_EC2 # Replace with your desired AMI ID
  instance_type   = "t2.micro"
  subnet_id       = module.vpc.public_subnets[0]
  security_groups = [aws_security_group.e9_bastion_sg.id]
  key_name        = var.KEY_PAIR
  #  user_data       = <<-EOF
  #                             #!/bin/bash
  #                             yum install wget unzip httpd -y
  #                             systemctl start httpd
  #                             systemctl enable httpd
  #                             wget https://www.tooplate.com/zip-templates/2117_infinite_loop.zip
  #                             unzip -o 2117_infinite_loop.zip
  #                             cp -r 2117_infinite_loop/* /var/www/html/
  #                             systemctl restart httpd
  #                           EOF
  tags = {
    Name = "e9-bastion"
  }
}

# Step 2: Create an AMI based on the instance
#resource "aws_ami_from_instance" "e9_ami_from_instance" {
#  name               = "e9_ami"
# source_instance_id = aws_instance.e9_ami_instance.id
#}