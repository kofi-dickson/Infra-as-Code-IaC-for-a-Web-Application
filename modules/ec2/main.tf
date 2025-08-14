# The main resource block for the EC2 instance.
resource "aws_instance" "IaC-WebApp" {
  # These attributes are not hardcoded.
  # Instead, they get their values from input variables.
  ami           = var.ami_id
  instance_type = var.instance_type
}
  