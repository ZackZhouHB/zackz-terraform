resource "aws_key_pair" "zztt7key" {
  key_name   = "zz-tt-7-key"
  public_key = file(var.PUB_KEY_PATH) # use file function to read key content from local key file
}