# `variables.tf`
variable "ec2_ami_id" {
  description = "The AMI ID to use for the EC2 instance."
  type        = string
}

variable "ec2_instance_type" {
  description = "The EC2 instance type."
  type        = string
  default     = "t2.micro"
}

variable "ec2_subnet_id" {
  description = "The ID of the subnet for the EC2 instance to be deployed into."
  type        = string
}

variable "rds_allocated_storage" {
  description = "The allocated storage (in GiB) for the RDS instance."
  type        = number
  default     = 20
}

variable "rds_storage_type" {
  description = "The storage type of the RDS instance."
  type        = string
  default     = "gp2"
}

variable "rds_engine" {
  description = "The database engine for the RDS instance."
  type        = string
  default     = "mysql"
}

variable "rds_engine_version" {
  description = "The database engine version."
  type        = string
  default     = "8.0.36"
}

variable "rds_instance_class" {
  description = "The instance class for the RDS instance."
  type        = string
  default     = "db.t3.micro"
}

variable "rds_db_name" {
  description = "The name of the database."
  type        = string
}

variable "rds_identifier" {
  description = "The unique identifier for the RDS instance."
  type        = string
}

variable "rds_db_username" {
  description = "The username for the RDS database."
  type        = string
}

variable "rds_password" {
  description = "The password for the RDS database. (It's recommended to use a more secure method like a vault or environment variable)"
  type        = string
}

variable "rds_parameter_group_name" {
  description = "The name of the DB parameter group."
  type        = string
}

variable "rds_publicly_accessible" {
  description = "Specifies whether the RDS instance is publicly accessible."
  type        = bool
  default     = false
}

variable "rds_skip_final_snapshot" {
  description = "Determines whether to skip the final snapshot on deletion."
  type        = bool
  default     = true
}

variable "rds_db_subnet_group_name" {
  description = "The name of the DB subnet group to associate with the instance."
  type        = string
}
