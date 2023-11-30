terraform {
  backend "s3" {
    bucket = "z-new-terraform-backend"
    key    = "e8/backend"
    region = "ap-southeast-2"
  }
}