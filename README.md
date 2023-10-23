# Terraform-exercises

README.md

This is a self-learning project named zack-iaac-terraform
The object is to practise infrastructure as a code by deploying a JAVA stack to AWS by using Terraform

The project will follow bellow stages :

Stage1 :
- Setup Terraform local IDE, setup providers as AWS
- Exercise to create environment vars
- Modules, Provisioners and output
- multi-resource exercise for key pairs, VPC, SG, subnets, EC2
Stage2:
- create S3 for state
- create backend resources
- RDS, ElasticCache $ Amazon MQ
- Beanstalk ENV
- Bastion host and DB initialization
- Deploy artifact

Stage3:
new aws networking practice: 

- create VPC with pub and pri subnets
- create pub and pri route table and associate with subnets (enable auto assign public IP in pun subnets)

Senario1: EC2 in pub subnet with intenet
- create bastion ec2 within new vpc public subnet, 
- create IGW attach to vpc, edit pub RT 
- install httpd on ec2 to validate internet access 
Senario1: EC2 in prv subnet accessible from bastion in pun subnet
- create bastion-sg 
- create ec2-prv in prv subnet, create prv-sg, configure bastion-sg to allow 22 from bastion to ec2-prv
- create key-pair for bastion ec2 ssh into ec2-prv
Senario3: ec2-prv in prv subnet with internet by NAT gateway
- create NATgateway wit ELP for pub subnet
- edit prv RT to allow traffic send to NAT GW for internet
Senario4: VPC peering for ec2 in default VPC can access httpd bastion in new VPC
- create ec2 in default vpc
- create vpc peering then validate

