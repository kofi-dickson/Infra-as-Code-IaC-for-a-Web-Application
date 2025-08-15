terraform {
  backend "s3" {
    bucket = "mybucket-tstate-1122xyz"
    key    = "demo-project/terraform.tfstate"
    region = "us-east-2"
    
    dynamodb_table = "demo-terraform-state-locks"
    encrypt = true
  }
}
