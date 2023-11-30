module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  # RT will be created automatically and associated with subnet accordingly


  name                    = var.VPC_NAME
  cidr                    = var.VPC_CIDR
  azs                     = [var.ZONE1, var.ZONE2]                       # Replace with your desired AZs
  private_subnets         = [var.PRI_SUBNET1_CIDR, var.PRI_SUBNET2_CIDR] # Replace with your desired CIDRs
  public_subnets          = [var.PUB_SUBNET1_CIDR, var.PUB_SUBNET2_CIDR] # Replace with your desired CIDRs
  map_public_ip_on_launch = true
  # enable single NATgateway to save cost
  enable_nat_gateway              = true
  single_nat_gateway              = true
  enable_dns_hostnames            = true
  enable_dns_support              = true
  map_customer_owned_ip_on_launch = true

  tags = {
    Terraform   = "true"
    Environment = "e9"
  }

  # give VPC tags
  vpc_tags = {
    name = var.VPC_NAME
  }
}
