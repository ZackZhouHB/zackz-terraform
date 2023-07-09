# define variables

variable "REGION" {
  default = "ap-southeast-2"
}

variable "ZONE1" {
  default = "ap-southeast-2a"
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