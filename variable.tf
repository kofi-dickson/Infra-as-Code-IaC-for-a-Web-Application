# `variables.tf`
variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type."
  type        = string
  default     = "t2.micro"
}

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

variable "name" {
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
  type        = string
  description = "The database password"
  sensitive   = true
}

variable "parameter_group_name" {
  type        = string
  description = "The parameter group name"
}

variable "publicly_accessible" {
  description = "value to allow public access to the RDS instance."
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "value to skip the final snapshot on DB deletion."
  type        = bool
  default = true
}