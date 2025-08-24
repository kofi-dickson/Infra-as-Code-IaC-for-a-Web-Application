provider "aws" {
  region = "us-east-2"
}

# Add the Vault provider to your configuration.
provider "vault" {}


data "vault_generic_secret" "rds_password" {
  path = "kv/data/rds_password/database"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's AWS account ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_rds_engine_version" "mysql" {
  engine = "mysql"
  version = "8.0.40"
}

# --------------------------------------------------------------------------------------------------
# MODULES
# These blocks instantiate your modules. The networking and security group resources
# are now managed by the 'vpc' module.
# --------------------------------------------------------------------------------------------------

# Call the new VPC module. This will create all your networking resources.
# Since all values are hardcoded inside the module, you don't need to pass any variables here.
module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source             = "./modules/ec2"
  ami_id             = data.aws_ami.ubuntu.id
  instance_type      = var.ec2_instance_type
  # Get the public subnet ID from the vpc module's outputs.
  subnet_id          = module.vpc.public_subnet_id
  # Get the EC2 security group ID from the vpc module's outputs.
  security_group_ids = [module.vpc.ec2_security_group_id]
}

module "rds" {
  source               = "./modules/rds"
  allocated_storage    = var.rds_allocated_storage
  engine_version       = data.aws_rds_engine_version.mysql.version
  storage_type         = var.rds_storage_type
  engine               = data.aws_rds_engine_version.mysql.engine
  instance_class       = var.rds_instance_class
  db_name              = var.rds_db_name
  identifier           = var.rds_identifier
  username             = var.rds_db_username
  password             = data.vault_generic_secret.rds_password.data["db_password"]   # db_password is the key in which i stored the password
  parameter_group_name = var.rds_parameter_group_name
  publicly_accessible  = false
  skip_final_snapshot  = var.rds_skip_final_snapshot
  # Get the DB subnet group name from the vpc module's outputs.
  db_subnet_group_name = module.vpc.db_subnet_group_name
  # Get the RDS security group ID from the vpc module's outputs.
  security_group_ids = [module.vpc.rds_security_group_id]
}

# --------------------------------------------------------------------------------------------------
# VAULT SERVER
# This is the resource block for the existing Vault EC2 instance you want to import.
# --------------------------------------------------------------------------------------------------
resource "aws_instance" "vault_server" {
  ami           = "ami-0cfde0ea8edd312d4"
  instance_type = "t2.micro"
  
  # Associate the instance with the public subnet and the new Vault security group,
  # both retrieved from the vpc module.
  subnet_id = module.vpc.public_subnet_id
  vpc_security_group_ids = [module.vpc.vault_security_group_id]

  tags = {
    Name = "vault_server"
  }
}
