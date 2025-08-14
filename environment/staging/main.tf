module "ec2" {
  source = "/Users/mac/Infra-as-Code-IaC-for-a-Web-Application/modules/ec2"
  ami = var.ami_id
  instance_type = var.instance_type
}