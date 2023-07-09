# define variables

variable "REGION" {
  default = "ap-southeast-2"
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


variable "AMIS" {
  type = map(any)
  default = {
    ap-southeast-2 = "ami-0d6294dcaac5546e4" # Sydney
    ap-southeast-1 = "ami-06b79cf2aee0d5c92" # Singapore
  }
}

variable "USER" {
  default = "ec2-user"
}

variable "PUB_KEY" {
  default = "zz-tt-3-1-key.pub"
}

variable "PRIV_KEY" {
  default = "zz-tt-3-1-key"
}

variable "MYIP" {
  default = "49.3.117.241/32"
}
