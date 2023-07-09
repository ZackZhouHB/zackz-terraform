
# need bastion to initialize RDS instance by running SQL query
# create bastion host execute database command

resource "aws_instance" "zzttstack-bastion" {
  ami                    = lookup(var.AMIS, var.REGION) # use lookup function to look for region names in the map VAR AMIs
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.zztt7key.key_name
  subnet_id              = aws_subnet.zzttstack-pub-1.id
  vpc_security_group_ids = [aws_security_group.zztt-stack-bastionsg.id]

  tags = {
    Name    = "zzttstack-bastion"
    PROJECT = "zzttstack"
  }

  # extract rds endpoint, use terraform "templatefile function"
  # create text file, put template info over there, mention vars (like rds-endpoint) which will be used in template
  # terraform will get vars with value, create text file from that, push templatefile function
  # first create shell for initialize rds "templates/db-deploy.tmpl"
  # use provisioner and file function to push sh to bastion with vars

  provisioner "file" {
    content     = templatefile("templates/db-deploy.tmpl", { rds-endpoint = aws_db_instance.zzttstack-rds.address, dbuser = var.dbuser, dbpass = var.dbpass })
    destination = "/tmp/zzttstack-dbdeploy.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod u+x /tmp/zzttstack-dbdeploy.sh",
      "sudo apt update",
      "sudo apt install mysql-client -y",
      "sudo bash /tmp/zzttstack-dbdeploy.sh"
    ]
  }

  connection {
    user        = var.USERNAME
    private_key = file(var.PRIV_KEY_PATH)
    host        = self.public_ip
  }
  depends_on = [aws_db_instance.zzttstack-rds]

}

output "PublicIP" {
  value = aws_instance.zzttstack-bastion.public_ip # resource type "aws_instance" . resource name "zz-tt-3". /
  # attribute "public_ip" (can find from docs)
}