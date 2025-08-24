
 variable "ami_id" {
  description = "The AMI ID for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type to use."
  type        = string
}
variable "subnet_id" {
  description = "The ID of the subnet to deploy the EC2 instance into."
  type        = string
}

variable "security_group_ids" {
  description = "A list of security group IDs to assign to the EC2 instance."
  type        = list(string)
}