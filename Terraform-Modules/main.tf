module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block           = var.vpc_cidr_block
  public_subnet_cidr_blocks = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  availability_zones       = var.availability_zones
  tags                     = var.tags
}

module "route_tables" {
  source = "./modules/route_tables"

  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  igw_id = module.vpc.igw_id
  nat_gateway_id = module.vpc.nat_gateway_id
  tags = var.tags
}

module "nacl" {
  source = "./modules/nacl"

  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  tags = var.tags
}

module "security_groups" {
  source = "./modules/security_groups"

  vpc_id = module.vpc.vpc_id
  tags = var.tags
}

module "ec2_instances" {
  source = "./modules/ec2_instances"

  public_subnet_id = module.vpc.public_subnet_ids[0]
  key_name = var.key_name
  ami = var.ami
  security_group_ids = [
    module.security_groups.bastion_sg_id
  ]
  tags = var.tags
}

module "route53" {
  source = "./modules/route53"

  domain_name = var.domain_name
  tags = var.tags
}
