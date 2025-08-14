terraform {
  backend "s3" {
    bucket = "mybucket-tstate-1122"
    key    = "demo-project/terraform.tfstate"
    region = "us-east-2"
  }
}
