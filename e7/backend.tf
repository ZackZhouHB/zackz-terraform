terraform {
  backend "s3" {
    bucket = "z-new-terraform-backend"
    key    = "e7/backend"
    region = "ap-southeast-2"
  }
}