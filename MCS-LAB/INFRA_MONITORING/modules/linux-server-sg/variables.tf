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

variable "common_tags" {
  description = "Common Tags"
  type        = map(string)
}