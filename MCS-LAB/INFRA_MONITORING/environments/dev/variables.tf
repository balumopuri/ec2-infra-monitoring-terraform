variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "application_name" {
  description = "ShiftChange"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID provided by the networking team"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID provided by the networking team"
  type        = string
}

variable "ssh_allowed_cidr" {
  description = "49.43.250.43/32"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string

}