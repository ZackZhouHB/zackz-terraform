resource "aws_key_pair" "zztt31key" {
  key_name   = "zz-tt-3-1-key"
  public_key = file("zz-tt-7-key.pub") # use file function to read key content from local key file
}

resource "aws_instance" "zz-tt-web1" {
  ami                    = var.AMIS[var.REGION] # will based on default region "Sydney" to pick the AMI from vars.tf
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1                       # from vars.tf
  key_name               = aws_key_pair.zztt31key.key_name # refer from another resource with resource name.referencename.attributename
  vpc_security_group_ids = ["sg-03465c5a5801a0e3f"]
  tags = {
    Name    = "zz-tt-7-web1"
    Project = "zack-terraform"
    # user_data = file("web.sh")  (not working )
  }

  provisioner "file" {
    source      = "2117_infinite_loop.zip"
    destination = "/tmp/2117_infinite_loop.zip"
  }

  #provisioner "file" {
  #  source      = "web.sh"
  #  destination = "/tmp/web.sh"
  #}

  provisioner "remote-exec" {
    inline = [
      #"chmod u+x /tmp/web2.sh",
      "sudo yum install wget unzip httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      # wget https://www.tooplate.com/zip-templates/2117_infinite_loop.zip 
      "cd /tmp",
      "sudo unzip -o 2117_infinite_loop.zip",
      "sudo cp -r 2117_infinite_loop/* /var/www/html/",
      "sudo systemctl restart httpd"
    ]
  }

  connection {
    user        = var.USER
    private_key = file("zz-tt-7-key")
    host        = self.public_ip
  }
}

output "PublicIP" {
  value = aws_instance.zz-tt-web1.public_ip # resource type "aws_instance" . resource name "zz-tt-3". /
  # attribute "public_ip" (can find from docs)
}

output "PrivateIP" {
  value = aws_instance.zz-tt-web1.private_ip # resource type "aws_instance" . resource name "zz-tt-3". /
  # attribute "public_ip" (can find from docs)
}

resource "aws_instance" "zz-tt-web2" {
  ami                    = var.AMIS[var.REGION] # will based on default region "Sydney" to pick the AMI from vars.tf
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1                       # from vars.tf
  key_name               = aws_key_pair.zztt31key.key_name # refer from another resource with resource name.referencename.attributename
  vpc_security_group_ids = ["sg-03465c5a5801a0e3f"]
  tags = {
    Name    = "zz-tt-7-web2"
    Project = "zack-terraform"
    # user_data = file("web.sh")  (not working )
  }

  provisioner "file" {
    source      = "2095_level.zip"
    destination = "/tmp/2095_level.zip"
  }

  #provisioner "file" {
  #  source      = "web2.sh"
  #  destination = "/tmp/web2.sh"
  #}

  provisioner "remote-exec" {
    inline = [
      #"chmod u+x /tmp/web2.sh",
      "sudo yum install wget unzip httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      # wget https://www.tooplate.com/zip-templates/2117_infinite_loop.zip 
      "cd /tmp",
      "sudo unzip -o 2095_level.zip",
      "sudo cp -r 2095_level/* /var/www/html/",
      "sudo systemctl restart httpd"
    ]
  }

  connection {
    user        = var.USER
    private_key = file("zz-tt-7-key")
    host        = self.public_ip
  }
}

output "PublicIP2" {
  value = aws_instance.zz-tt-web2.public_ip # resource type "aws_instance" . resource name "zz-tt-3". /
  # attribute "public_ip" (can find from docs)
}

output "PrivateIP2" {
  value = aws_instance.zz-tt-web2.private_ip # resource type "aws_instance" . resource name "zz-tt-3". /
  # attribute "public_ip" (can find from docs)
}

resource "aws_instance" "zz-tt-web3" {
  ami                    = var.AMIS[var.REGION] # will based on default region "Sydney" to pick the AMI from vars.tf
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1                       # from vars.tf
  key_name               = aws_key_pair.zztt31key.key_name # refer from another resource with resource name.referencename.attributename
  vpc_security_group_ids = ["sg-03465c5a5801a0e3f"]
  tags = {
    Name    = "zz-tt-7-web3"
    Project = "zack-terraform"
    # user_data = file("web.sh")  (not working )
  }

  provisioner "file" {
    source      = "templatemo_588_ebook_landing.zip"
    destination = "/tmp/templatemo_588_ebook_landing.zip"
  }

  #provisioner "file" {
  #  source      = "web2.sh"
  #  destination = "/tmp/web2.sh"
  #}

  provisioner "remote-exec" {
    inline = [
      #"chmod u+x /tmp/web2.sh",
      "sudo yum install wget unzip httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      # wget https://www.tooplate.com/zip-templates/2117_infinite_loop.zip 
      "cd /tmp",
      "sudo unzip -o templatemo_588_ebook_landing.zip",
      "sudo cp -r templatemo_588_ebook_landing/* /var/www/html/",
      "sudo systemctl restart httpd"
    ]
  }

  connection {
    user        = var.USER
    private_key = file("zz-tt-7-key")
    host        = self.public_ip
  }
}

output "PublicIP3" {
  value = aws_instance.zz-tt-web3.public_ip # resource type "aws_instance" . resource name "zz-tt-3". /
  # attribute "public_ip" (can find from docs)
}

output "PrivateIP3" {
  value = aws_instance.zz-tt-web3.private_ip # resource type "aws_instance" . resource name "zz-tt-3". /
  # attribute "public_ip" (can find from docs)
}


resource "aws_instance" "zz-tt-web4" {
  ami                    = var.AMIS[var.REGION] # will based on default region "Sydney" to pick the AMI from vars.tf
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1                       # from vars.tf
  key_name               = aws_key_pair.zztt31key.key_name # refer from another resource with resource name.referencename.attributename
  vpc_security_group_ids = ["sg-03465c5a5801a0e3f"]
  tags = {
    Name    = "zz-tt-7-web4"
    Project = "zack-terraform"
    # user_data = file("web.sh")  (not working )
  }

  provisioner "file" {
    source      = "templatemo_557_grad_school.zip"
    destination = "/tmp/templatemo_557_grad_school.zip"
  }

  #provisioner "file" {
  #  source      = "web2.sh"
  #  destination = "/tmp/web2.sh"
  #}

  provisioner "remote-exec" {
    inline = [
      #"chmod u+x /tmp/web2.sh",
      "sudo yum install wget unzip httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      # wget https://www.tooplate.com/zip-templates/2117_infinite_loop.zip 
      "cd /tmp",
      "sudo unzip -o templatemo_557_grad_school.zip",
      "sudo cp -r templatemo_557_grad_school/* /var/www/html/",
      "sudo systemctl restart httpd"
    ]
  }

  connection {
    user        = var.USER
    private_key = file("zz-tt-7-key")
    host        = self.public_ip
  }
}

output "PublicIP4" {
  value = aws_instance.zz-tt-web4.public_ip # resource type "aws_instance" . resource name "zz-tt-3". /
  # attribute "public_ip" (can find from docs)
}

output "PrivateIP4" {
  value = aws_instance.zz-tt-web4.private_ip # resource type "aws_instance" . resource name "zz-tt-3". /
  # attribute "public_ip" (can find from docs)
}


# backend:
# terraform state is local
# if in a team, diff people make change will have diff state of infrastructure
# Terraform state should be in sync, then Terraform state file should be same across all execution
# best to put Terraform state file in a remote location (AWS S3)

# with backend state in S3, other change by diff people will be updated to backend state
# to achive the state concept of marntaining infrastructure in same level in /
# a centralized location that can support mutiple changes applied. 

