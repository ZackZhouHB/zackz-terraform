# Step 1: Create an EC2 instance with user data
resource "aws_instance" "e7_ami_instance" {
  ami             = var.AMIS_EC2 # Replace with your desired AMI ID
  instance_type   = "t2.micro"
  subnet_id       = module.vpc.public_subnets[0]
  security_groups = [aws_security_group.elb-sg.id]
  user_data       = <<-EOF
                             #!/bin/bash
                             yum install wget unzip httpd -y
                             systemctl start httpd
                             systemctl enable httpd
                             wget https://www.tooplate.com/zip-templates/2117_infinite_loop.zip
                             unzip -o 2117_infinite_loop.zip
                             cp -r 2117_infinite_loop/* /var/www/html/
                             systemctl restart httpd
                           EOF
  tags = {
    Name = "e7-example-instance"
  }
  depends_on = [aws_security_group.elb-sg]
}

# Step 2: Create an AMI based on the instance
resource "aws_ami_from_instance" "e7_ami_from_instance" {
  name               = "e7_ami"
  source_instance_id = aws_instance.e7_ami_instance.id
}