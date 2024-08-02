resource "aws_network_acl" "public" {
  vpc_id = var.vpc_id

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = merge(var.tags, { Name = "Public NACL" })
}

resource "aws_network_acl" "private" {
  vpc_id = var.vpc_id

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.0.0.0/25"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "udp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "10.0.0.0/25"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "icmp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "10.0.0.0/25"
    from_port  = 0
    to_port    = 65535
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = merge(var.tags, { Name = "Private NACL" })
}

resource "aws_network_acl_association" "public" {
  count = length(var.public_subnet_ids)
  subnet_id = element(var.public_subnet_ids, count.index)
  network_acl_id = aws_network_acl.public.id
}

resource "aws_network_acl_association" "private" {
  count = length(var.private_subnet_ids)
  subnet_id = element(var.private_subnet_ids, count.index)
  network_acl_id = aws_network_acl.private.id
}
