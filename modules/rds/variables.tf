variable "allocated_storage" {
  type        = number
  description = "The allocated storage"
}

variable "storage_type" {
  type        = string
  description = "The storage type"
}

variable "engine" {
  type        = string
  description = "The database engine"
}

variable "engine_version" {
  type        = string
  description = "The database engine version"
}

variable "instance_class" {
  type        = string
  description = "The instance class"
}

variable "db_name" {
  type        = string
  description = "The database name"
}

variable "identifier" {
  type        = string
  description = "The database identifier"
}

variable "username" {
  type        = string
  description = "The database username"
}

variable "password" {
  description = "The master password for the database."
  type        = string
  sensitive   = true 
}

variable "parameter_group_name" {
  type        = string
  description = "The parameter group name"
}

variable "publicly_accessible" {
  description = "Set to true to allow public access to the RDS instance."
  type        = bool
  default     = true
}
variable "skip_final_snapshot" {
  description = "Set to true to skip the final snapshot on DB deletion."
  type        = bool
  default     = true 
}

variable "db_subnet_group_name" {
  description = "Name of the DB subnet group to place the RDS instance in."
  type        = string
}

variable "security_group_ids" {
  description = "A list of VPC security group IDs to associate with the RDS instance."
  type        = list(string)
}
