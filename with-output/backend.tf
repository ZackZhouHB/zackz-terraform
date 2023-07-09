terraform {
  backend "s3" {
    bucket = "zz-tt-3-tf-state"
    key    = "tf-state/backend_exer6"
    region = "ap-southeast-2"
  }
}
