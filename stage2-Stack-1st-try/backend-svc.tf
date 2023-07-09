resource "aws_db_subnet_group" "zzttstack-rds-subgrp" {
  name       = "main"
  subnet_ids = [aws_subnet.zzttstack-priv-1.id, aws_subnet.zzttstack-priv-2.id, aws_subnet.zzttstack-priv-3.id]
  tags = {
    Name = "Subnet group for RDS"
  }
}

resource "aws_elasticache_subnet_group" "zzttstack-ecache-subgrp" {
  name       = "zz-tt-stack-ecache-subgrp"
  subnet_ids = [aws_subnet.zzttstack-priv-1.id, aws_subnet.zzttstack-priv-2.id, aws_subnet.zzttstack-priv-3.id]

}

resource "aws_db_instance" "zzttstack-rds" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7.42"
  instance_class         = "db.t2.micro"
  db_name                = var.dbname
  username               = var.dbuser
  password               = var.dbpass
  parameter_group_name   = "default.mysql5.7"
  multi_az               = "false"
  publicly_accessible    = "false"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.zzttstack-rds-subgrp.name
  vpc_security_group_ids = [aws_security_group.zztt-stack-backend-sg.id]
}

resource "aws_elasticache_cluster" "zzttstack-cache" {
  cluster_id           = "zz-tt-stack-cache"
  engine               = "memcached"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.6"
  port                 = 11211
  security_group_ids   = [aws_security_group.zztt-stack-backend-sg.id]
  subnet_group_name    = aws_elasticache_subnet_group.zzttstack-ecache-subgrp.name
}

resource "aws_mq_broker" "zzttstack-rmq" {
  broker_name        = "zz-tt-stack-rmq"
  engine_type        = "ActiveMQ"
  engine_version     = "5.15.0"
  host_instance_type = "mq.t2.micro"
  security_groups    = [aws_security_group.zztt-stack-backend-sg.id]
  subnet_ids         = [aws_subnet.zzttstack-priv-1.id]

  user {
    username = var.rmquser
    password = var.rmqpass
  }
}