terraform {
  backend "s3" {
    bucket = "zz-tt-3-tf-state"
    key    = "tf-state/backend_stack"
    region = "ap-southeast-2"
  }
}
