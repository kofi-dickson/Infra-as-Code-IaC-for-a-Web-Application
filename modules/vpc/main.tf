# --------------------------------------------------------------------------------------------------
# NETWORKING RESOURCES
# These resources create the VPC and subnets required for your EC2 and RDS instances.
# This setup follows security best practices by separating public and private resources.
# --------------------------------------------------------------------------------------------------

# Create a new VPC for the application.
resource "aws_vpc" "app_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "WebAppVPC"
  }
}

# Create a single public subnet. This is where your EC2 instance will reside.
resource "aws_subnet" "public_subnet" {
  vpc_id                = aws_vpc.app_vpc.id
  cidr_block            = "10.0.1.0/24"
  availability_zone     = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicSubnet"
  }
}

# Create the first private subnet for RDS.
resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2a"
  tags = {
    Name = "PrivateSubnetA"
  }
}

# Create a second private subnet for RDS in a different Availability Zone.
resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-2b"
  tags = {
    Name = "PrivateSubnetB"
  }
}

# Create a DB Subnet Group for RDS.
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "main-db-subnet-group"
  subnet_ids = [
    aws_subnet.private_subnet_a.id,
    aws_subnet.private_subnet_b.id,
  ]
  tags = {
    Name = "Main DB Subnet Group"
  }
}

# Create an Internet Gateway for the public subnet.
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    Name = "InternetGateway"
  }
}

# Create an Elastic IP for the NAT Gateway.
resource "aws_eip" "nat_eip" {
  tags = {
    Name = "NAT EIP"
  }
}

# Create a NAT Gateway in the public subnet.
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id
  tags = {
    Name = "NAT Gateway"
  }
}

# Add a VPC Endpoint for S3.
resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id            = aws_vpc.app_vpc.id
  service_name      = "com.amazonaws.us-east-2.s3"
  vpc_endpoint_type = "Gateway"
  tags = {
    Name = "S3 Endpoint"
  }
}

# Create a route table to direct public traffic through the Internet Gateway.
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.app_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "PublicRouteTable"
  }
}

# Create a route table for the private subnets.
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.app_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = {
    Name = "PrivateRouteTable"
  }
}

# Add a route to the S3 endpoint in the private route table.
resource "aws_vpc_endpoint_route_table_association" "s3_endpoint_association" {
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
  route_table_id  = aws_route_table.private_route_table.id
}

# Associate the public route table with the public subnet.
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Associate the private route table with both private subnets.
resource "aws_route_table_association" "private_association_a" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_association_b" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_route_table.id
}

# --------------------------------------------------------------------------------------------------
# SECURITY GROUPS
# --------------------------------------------------------------------------------------------------

# Security group for the EC2 instance.
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "Allow inbound HTTP, HTTPS, and SSH traffic"
  vpc_id      = aws_vpc.app_vpc.id

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Allow inbound HTTP, HTTPS, and SSH.
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # WARNING: This allows SSH from anywhere. Restrict this!
  }
}

# Security group for the RDS database.
resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Allow inbound traffic from the EC2 security group"
  vpc_id      = aws_vpc.app_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3306 # Replace with your database's port
    to_port     = 3306 # Replace with your database's port
    protocol    = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }
}

# Security group for the Vault server.
resource "aws_security_group" "vault_sg" {
  name        = "vault-security-group"
  description = "Allow inbound SSH and Vault (8200) traffic"
  vpc_id      = aws_vpc.app_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # WARNING: This allows SSH from anywhere. Restrict this!
  }
  ingress {
    from_port   = 8200
    to_port     = 8200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  output "vault_security_group_id" {
  value = aws_security_group.vault_sg.id
 }