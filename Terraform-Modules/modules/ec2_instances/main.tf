resource "aws_instance" "bastion" {
  ami           = var.ami
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet_id
  key_name      = var.key_name

  security_group_ids = var.security_group_ids

  tags = merge(var.tags, { Name = "Bastion Host" })
}
