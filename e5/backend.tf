terraform {
  backend "s3" {
    bucket = "z-new-terraform-backend"
    key    = "e5/backend"
    region = "ap-southeast-2"
  }
}