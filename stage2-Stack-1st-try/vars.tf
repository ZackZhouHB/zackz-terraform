# define variables

variable "REGION" {
  default = "ap-southeast-2"
}

variable "AMIS" {
  type = map(any)
  default = {
    ap-southeast-2 = "ami-0310483fb2b488153" # Sydney  #Ubuntu22.04 LTS
    ap-southeast-1 = "ami-0df7a207adb9748c7" # Singapore
  }
}

variable "PRIV_KEY_PATH" {
  default = "zz-tt-7-key"
}

variable "PUB_KEY_PATH" {
  default = "zz-tt-7-key.pub"
}


variable "USERNAME" {
  default = "ubuntu"
}

variable "rmquser" {
  default = "rabbit"
}

variable "rmqpass" {
  default = "P@ssword123123"
}

variable "dbuser" {
  default = "admin"
}

variable "dbpass" {
  default = "admin123"
}

variable "dbname" {
  default = "accounts"
}

variable "instance_count" {
  default = "1"
}

variable "MYIP" {
  default = "49.3.117.241/32"
}

variable "VPC_NAME" {
  default = "zz-tt-stack-vpc"
}

variable "ZONE1" {
  default = "ap-southeast-2a"
}

variable "ZONE2" {
  default = "ap-southeast-2b"
}

variable "ZONE3" {
  default = "ap-southeast-2c"
}

variable "Vpc_CIDR" {
  default = "172.21.0.0/16"
}

variable "PubSub1CIDR" {
  default = "172.21.1.0/24"
}

variable "PubSub2CIDR" {
  default = "172.21.2.0/24"
}

variable "PubSub3CIDR" {
  default = "172.21.3.0/24"
}

variable "PrivSub1CIDR" {
  default = "172.21.4.0/24"
}

variable "PrivSub2CIDR" {
  default = "172.21.5.0/24"
}

variable "PrivSub3CIDR" {
  default = "172.21.6.0/24"
}
