provider "aws" {
    region = "us-east-2"
}
provider "vault"{
  address = ""
  token = ""
}

module "ec2" {
  source = "./modules/ec2"
  ami_id = ""
  instance_type = "t2.micro"
}

module "rds" {
  source = "./modules/rds"
  allocated_storage    = 
  storage_type         = 
  engine               = 
  engine_version       = 
  instance_class       = 
  db_name              = 
  username             = 
  password             = 
  parameter_group_name = 
}
