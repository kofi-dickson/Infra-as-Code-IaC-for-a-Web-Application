# `outputs.tf`
output "instance_id" {
  description = "The ID of the created EC2 instance."
  value       = aws_instance.IaC-WebApp.id
}

output "public_ip" {
  description = "The public IP address of the EC2 instance."
  value       = aws_instance.IaC-WebApp.public_ip
}
