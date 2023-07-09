resource "aws_key_pair" "zztt31key" {
  key_name   = "zz-tt-3-1-key"
  public_key = file("zz-tt-3-1-key.pub") # use file function to read key content from local key file
}

resource "aws_instance" "zz-tt-3" {
  ami                    = var.AMIS[var.REGION] # will based on default region "Sydney" to pick the AMI from vars.tf
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1                       # from vars.tf
  key_name               = aws_key_pair.zztt31key.key_name # refer from another resource with resource name.referencename.attributename
  vpc_security_group_ids = ["sg-03465c5a5801a0e3f"]
  tags = {
    Name    = "zz-tt-3-1"
    Project = "zack-terraform"
    # user_data = file("web.sh")  (not working )
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

  connection {
    user        = var.USER
    private_key = file("zz-tt-3-1-key")
    host        = self.public_ip
  }
}

output "PublicIP" {
  value = aws_instance.zz-tt-3.public_ip # resource type "aws_instance" . resource name "zz-tt-3". /
  # attribute "public_ip" (can find from docs)
}

output "PrivateIP" {
  value = aws_instance.zz-tt-3.private_ip # resource type "aws_instance" . resource name "zz-tt-3". /
  # attribute "public_ip" (can find from docs)
}
