terraform {
  backend "s3" {
    bucket = "zz-tt-3-tf-state"
    key    = "tf-state/backend"
    region = "ap-southeast-2"
  }
}
