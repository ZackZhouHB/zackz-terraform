resource "aws_instance" "e8_bastion_host" {
  ami             = var.AMIS # Amazon Linux 2 AMI, change as needed
  instance_type   = "t2.micro"
  subnet_id       = module.vpc.public_subnets[0]
  security_groups = [aws_security_group.bastion-test.id]

  key_name = "terraform-new-key1" # Change as needed

  tags = {
    Name    = "e8-easy-bastion-host"
    Project = "e8-easy"
  }
}

# sudo apt-get update && sudo apt install mysql-client-core-8.0

resource "aws_db_instance" "e8_mysql" {
  allocated_storage      = 10
  db_name                = "mydb"
  engine                 = "mysql"
  engine_version         = "8.0.33"
  instance_class         = "db.t2.micro"
  username               = "zz"
  password               = "admin123"
  skip_final_snapshot    = true
  publicly_accessible    = false
  db_subnet_group_name = aws_db_subnet_group.e8_db_sng.name
  vpc_security_group_ids = [aws_security_group.backend-test.id]
}

resource "aws_db_subnet_group" "e8_db_sng" {
  name       = "e8-db-sng"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]

  tags = {
    Name = "e8 subnet group"
  }
}
