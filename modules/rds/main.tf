resource "aws_db_instance" "terra_db" {
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
}
 