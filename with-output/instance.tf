resource "aws_key_pair" "zztt31key" {
  key_name   = "zz-tt-3-1-key"
  public_key = file("zz-tt-3-1-key.pub") # use file function to read key content from local key file
}

resource "aws_instance" "zz-tt-web" {
  ami                    = var.AMIS[var.REGION] # will based on default region "Sydney" to pick the AMI from vars.tf
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.zz-tt-6-pub-1.id
  key_name               = aws_key_pair.zztt31key.key_name # refer from another resource with resource name.referencename.attributename
  vpc_security_group_ids = [aws_security_group.zz-tt-stack-sg.id]
  tags = {
    Name    = "zz-tt-web"
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

resource "aws_ebs_volume" "vol-zz-tt" {
  availability_zone = var.ZONE1 # EBS vol should be in the same zone of ec2
  size              = 3
  tags = {
    Name = "extra-vol-zz-tt"
  }
}

resource "aws_volume_attachment" "ebs-att-zz-tt-web" {
  device_name = "/dev/xvdh" ## not sure
  volume_id   = aws_ebs_volume.vol-zz-tt.id
  instance_id = aws_instance.zz-tt-web.id
}

output "PublicIP" {
  value = aws_instance.zz-tt-web.public_ip # resource type "aws_instance" . resource name "zz-tt-3". /
  # attribute "public_ip" (can find from docs)
}

output "PrivateIP" {
  value = aws_instance.zz-tt-web.private_ip # resource type "aws_instance" . resource name "zz-tt-3". /
  # attribute "public_ip" (can find from docs)
}
