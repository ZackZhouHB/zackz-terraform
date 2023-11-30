terraform {
  backend "s3" {
    bucket = "z-new-terraform-backend"
    key    = "e6/backend"
    region = "ap-southeast-2"
  }
}