provider "aws" {
    region = "us-east-2"
}


module "ec2" {
  source = "./modules/ec2"
  ami_id = var.ami_id
  instance_type = var.instance_type
}

module "rds" {
  source = "./modules/rds"
  allocated_storage    = var.allocated_storage
  storage_type         = var.storage_type
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  db_name              = var.db_name
  identifier           = var.identifier
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  publicly_accessible  =  var.publicly_accessible
  skip_final_snapshot  =  var.skip_final_snapshot
}