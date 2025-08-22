output "rds_instance_id" {
  value       = aws_db_instance.terra_db.id
  description = "The ID of the RDS instance"
}

output "rds_instance_endpoint" {
  value       = aws_db_instance.terra_db.endpoint
  description = "The endpoint of the RDS instance"
}

output "rds_instance_database_name" {
  value       = aws_db_instance.terra_db.db_name
  description = "The name of the database"
}

output "rds_instance_username" {
  value       = aws_db_instance.terra_db.username
  description = "The username of the database"
}

output "rds_instance_password" {
  value       = aws_db_instance.terra_db.password
  sensitive   = true
  description = "The password of the database"
}