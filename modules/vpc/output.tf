# Define all the outputs from this module that your root file will need.

# Output the VPC ID.
output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.app_vpc.id
}

# Output the public subnet ID.
output "public_subnet_id" {
  description = "The ID of the public subnet."
  value       = aws_subnet.public_subnet.id
}

# Output the database subnet group name.
output "db_subnet_group_name" {
  description = "The name of the DB subnet group."
  value       = aws_db_subnet_group.db_subnet_group.name
}

# Output the ID of the EC2 security group.
output "ec2_security_group_id" {
  description = "The ID of the EC2 security group."
  value       = aws_security_group.ec2_sg.id
}

# Output the ID of the RDS security group.
output "rds_security_group_id" {
  description = "The ID of the RDS security group."
  value       = aws_security_group.rds_sg.id
}
