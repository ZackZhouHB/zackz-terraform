resource "aws_elastic_beanstalk_environment" "zzttstack-prod-beanenv" {
  name                = "zz-tt-stack-prod-beanenv"
  application         = aws_elastic_beanstalk_application.zzttstack-prod-beanapp.name # .name as a string is needed
  solution_stack_name = "64bit Amazon Linux 2 v4.3.9 running Tomcat 8.5 Corretto 11"
  cname_prefix        = "zzttstack-beanprod-domain"
  setting {
    name      = "VPCId"
    namespace = "aws:ec2:vpc"
    value     = aws_vpc.zzttstack-vpc.id
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-beanstalk-ec2-role"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "false"
  }

  setting { # use "join" in terraform "String function" to join list (subnets) in to a string
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", [aws_subnet.zzttstack-priv-1.id, aws_subnet.zzttstack-priv-2.id, aws_subnet.zzttstack-priv-3.id])
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = join(",", [aws_subnet.zzttstack-priv-1.id, aws_subnet.zzttstack-priv-2.id, aws_subnet.zzttstack-priv-3.id])
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = aws_key_pair.zztt7key.key_name
  }

  setting { # 3 subnets in 3 azs
    namespace = "aws:autoscaling:asg"
    name      = "Availability Zones"
    value     = "Any 3"
  }
  setting { # autoscaling settings minimal
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "1"
  }
  setting { # autoscaling settings maximal
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = "8"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "environment"
    value     = "prod"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "LOGGING_APPENDER"
    value     = "GRAYLOG"
  }
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }
  setting { # rolling update
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateEnabled"
    value     = "true"
  }
  setting { # rolling update policy, based on "Health", if health, then go the next
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateType"
    value     = "Health"
  }

  setting { # 1 instance at a time., or set by percentage 
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "MaxBatchSize"
    value     = "1"
  }
  setting {
    namespace = "aws:elb:loadbalancer"
    name      = "CrossZone"
    value     = "true"
  }

  setting { # namespace from aws beanstalk developer guide doc, enable stickuness
    name      = "StickinessEnabled"
    namespace = "aws:elasticbeanstalk:environment:process:default"
    value     = "true"
  }

  setting { # batch size as fixed, 1 at a time, can be given by percentage
    namespace = "aws:elasticbeanstalk:command"
    name      = "BatchSizeType"
    value     = "Fixed"
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "BatchSize"
    value     = "1"
  }
  setting { # deployment policy: rolling
    namespace = "aws:elasticbeanstalk:command"
    name      = "DeploymentPolicy"
    value     = "Rolling"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = aws_security_group.zztt-stack-bean-sg.id
  }

  setting {
    namespace = "aws:elbv2:loadbalancer"
    name      = "SecurityGroups"
    value     = aws_security_group.zztt-stack-beanelbsg.id
  }
  # add dependency in case beanstalk instance created prior SG created
  depends_on = [aws_security_group.zztt-stack-beanelbsg, aws_security_group.zztt-stack-bean-sg]

}

