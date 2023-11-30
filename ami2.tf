# Step 1: Create an EC2 instance with user data
resource "aws_instance" "e9_ami_instance_2" {
  ami             = var.AMIS_EC2 # Replace with your desired AMI ID
  instance_type   = "t2.micro"
  subnet_id       = module.vpc.public_subnets[0]
  security_groups = [aws_security_group.elb-sg.id]
  user_data       = <<-EOF
                             #!/bin/bash
                             yum install wget unzip httpd -y
                             systemctl start httpd
                             systemctl enable httpd
                             wget https://github.com/ZackZhouHB/zackz-terraform/blob/with-terraform/4-web-apps/templatemo_557_grad_school.zip
                             unzip -o templatemo_557_grad_school.zip
                             cp -r templatemo_557_grad_school/* /var/www/html/
                             systemctl restart httpd
                           EOF
  tags = {
    Name = "e9-example-instance-2"
  }
  depends_on = [aws_security_group.elb-sg]
}

# Step 2: Create an AMI based on the instance
resource "aws_ami_from_instance" "e9_ami_from_instance_2" {
  name               = "e9_ami_2"
  source_instance_id = aws_instance.e9_ami_instance_2.id
}