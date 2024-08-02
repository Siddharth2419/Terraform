variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/25"
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.0.0/28", "10.0.0.16/28"]
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.0.32/28", "10.0.0.48/28", "10.0.0.64/28"]
}

variable "availability_zones" {
  description = "Availability zones for the subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {
    Environment = "dev"
  }
}

variable "key_name" {
  description = "Key name for the EC2 instances"
  type        = string
  default     = "pem.key"
}

variable "ami" {
  description = "AMI ID for the EC2 instances"
  type        = string
  default     = "ami-04a81a99f5ec58529"
}

variable "domain_name" {
  description = "Domain name for Route 53"
  type        = string
  default     = "indiantech.fun"
}
