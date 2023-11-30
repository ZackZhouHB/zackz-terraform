variable "AWS_REGION" {
  default = "ap-southeast-2"
}

variable "AMIS" {
  default = "ami-0df4b2961410d4cff"
}

variable "AMIS_EC2" {
  default = "ami-0f5f922f781854672"
}

variable "KEY_PAIR" {
  default = "terraform-new-key1"
}

variable "PRIV_KEY_PATH" {
  default = "e8key"
}

variable "PUB_KEY_PATH" {
  default = "e8key.pub"
}

variable "USER" {
  default = "ubuntu"
}

variable "USER_EC2" {
  default = "ec2-user"
}

variable "MY_IP" {
  default = "1ssssss6/32"
}

variable "INSTANCE_COUNT" {
  default = "1"
}

variable "VPC_NAME" {
  default = "e8-vpc"
}

variable "VPC_CIDR" {
  default = "172.99.0.0/16"
}

variable "ZONE1" {
  default = "ap-southeast-2a"
}

variable "ZONE2" {
  default = "ap-southeast-2b"
}

variable "PUB_SUBNET1_CIDR" {
  default = "172.99.1.0/24"
}

variable "PUB_SUBNET2_CIDR" {
  default = "172.99.2.0/24"
}

variable "PRI_SUBNET1_CIDR" {
  default = "172.99.3.0/24"
}

variable "PRI_SUBNET2_CIDR" {
  default = "172.99.4.0/24"
}