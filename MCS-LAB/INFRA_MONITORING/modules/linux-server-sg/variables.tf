variable "application_name" {
  description = "Application Name"
  type        = string
}

variable "environment" {
  description = "Environment Name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "ssh_allowed_cidr" {
  description = "Allowed SSH CIDR"
  type        = string
}

variable "ec2_instance_connect_cidr" {
  description = "AWS EC2 Instance Connect service CIDR for the deployment region (allows browser-based console SSH). Find yours at https://ip-ranges.amazonaws.com/ip-ranges.json, service=EC2_INSTANCE_CONNECT."
  type        = string
}

variable "common_tags" {
  description = "Common Tags"
  type        = map(string)
}