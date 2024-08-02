resource "aws_vpc" "this" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  tags = merge(var.tags, { Name = "ot-micro-vpc" })
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr_blocks)
  vpc_id = aws_vpc.this.id
  cidr_block = element(var.public_subnet_cidr_blocks, count.index)
  availability_zone = element(var.availability_zones, count.index % length(var.availability_zones))
  map_public_ip_on_launch = true
  tags = merge(var.tags, { Name = "Public Subnet ${count.index + 1}" })
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr_blocks)
  vpc_id = aws_vpc.this.id
  cidr_block = element(var.private_subnet_cidr_blocks, count.index)
  availability_zone = element(var.availability_zones, count.index % length(var.availability_zones))
  tags = merge(var.tags, { Name = "Private Subnet ${count.index + 1}" })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = merge(var.tags, { Name = "igw1-ot-micro" })
}

resource "aws_eip" "this" {
  domain = "vpc"
  tags = merge(var.tags, { Name = "ot-micro-elasticip" })
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id = aws_subnet.public[0].id
  tags = merge(var.tags, { Name = "NAT Gateway" })
}

output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_ids" {
  value = aws_subnet.public.*.id
}

output "private_subnet_ids" {
  value = aws_subnet.private.*.id
}

output "igw_id" {
  value = aws_internet_gateway.this.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.this.id
}
