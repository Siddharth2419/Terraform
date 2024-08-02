variable "ami" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

variable "public_subnet_id" {
  description = "Public Subnet ID"
  type        = string
}

variable "key_name" {
  description = "Key name"
  type        = string
}

variable "security_group_ids" {
  description = "Security Group IDs"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}
