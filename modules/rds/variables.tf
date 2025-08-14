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