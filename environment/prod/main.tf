module "ec2" {
  source = "./modules/ec2"
  ami = var.ami_id
  instance_type = var.instance_type
}