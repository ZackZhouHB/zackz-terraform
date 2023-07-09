terraform {
  backend "s3" {
    bucket = "zz-tt-3-tf-state"
    key    = "tf-state/backend_redesign"
    region = "ap-southeast-2"
  }
}
