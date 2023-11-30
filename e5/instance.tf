
resource "aws_instance" "e3_bastion_host" {
  ami             = var.AMIS # Amazon Linux 2 AMI, change as needed
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.e3_public_subnet_1.id
  security_groups = [aws_security_group.e3_sg_bastion.id]

  key_name = "terraform-new-key1" # Change as needed

  tags = {
    Name    = "e3-easy-bastion-host"
    Project = "e3-easy"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"                       # Replace with your EC2 user
    private_key = file("terraform-new-key1.pem") # Replace with the path to your private key
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "ansible.sh"
    destination = "/home/ubuntu/ansible.sh"
  }
  provisioner "file" {
    source      = "terraform-new-key1.pem"
    destination = "/home/ubuntu/terraform-new-key1.pem"
  }
  provisioner "file" {
    source      = "pb1.yaml"
    destination = "/home/ubuntu/pb1.yaml"
  }
  provisioner "file" {
    source      = "pb4.yaml"
    destination = "/home/ubuntu/pb4.yaml"
  }
  provisioner "file" {
    source      = "aws_ec2.yaml"
    destination = "/home/ubuntu/aws_ec2.yaml"
  }
  provisioner "remote-exec" {
    inline = [
      "cd /home/ubuntu/",
      "sudo chmod 600 terraform-new-key1.pem",
      "sudo chmod +x ansible.sh",
      "sudo ./ansible.sh",
      "sudo ansible-inventory -i aws_ec2.yaml --list",
      "sudo ansible-inventory --graph",
      "sudo ansible-playbook pb4.yaml"
    ]
  }
  depends_on = [aws_instance.e3_backend_server_1]
}

resource "aws_instance" "e3_backend_server_1" {
  ami             = var.AMIS # Amazon Linux 2 AMI, change as needed
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.e3_private_subnet_1.id
  security_groups = [aws_security_group.e3_backend_sg.id]

  key_name = "terraform-new-key1" # Change as needed
  tags = {
    Name    = "e3-redis"
    Project = "e3"
  }
}

output "bastion-host-IP1" {
  value = aws_instance.e3_bastion_host.public_ip
}
output "bastion-host-IP2" {
  value = aws_instance.e3_bastion_host.private_ip
}

output "e3_backend_server_1-IPs" {
  value = aws_instance.e3_backend_server_1.private_ip
}

