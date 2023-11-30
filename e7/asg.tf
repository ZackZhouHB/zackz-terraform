# Launch Template Resource
resource "aws_launch_template" "e7_lt" {
  name                 = "e7-lt"
  description = "My Launch Template"
  image_id             = aws_ami_from_instance.e7_ami_from_instance.id # Specify your AMI ID
  instance_type        = "t2.micro"
  vpc_security_group_ids = [aws_security_group.elb-sg.id]
  key_name             = var.KEY_PAIR
  update_default_version = true
}

resource "aws_autoscaling_group" "e7_asg" {
  desired_capacity = 2
  max_size         = 3
  min_size         = 1
  launch_template {
    id = aws_launch_template.e7_lt.id
  }
  vpc_zone_identifier = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]
  target_group_arns   = [aws_lb_target_group.e7-tg.arn]
}

resource "aws_lb_listener" "e7_listener" {
  load_balancer_arn = aws_lb.e7_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.e7-tg.arn
    type             = "forward"
  }
}