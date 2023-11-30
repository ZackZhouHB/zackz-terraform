resource "aws_lb" "e7_lb" {
  name               = "e7-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb-sg.id]
  subnets            = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]

  tags = {
    Project = "e7"
  }
}

resource "aws_lb_target_group" "e7-tg" {
  name     = "e7-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}