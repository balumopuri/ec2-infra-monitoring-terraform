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
  description = "Allowed source CIDR for direct SSH access (e.g. your office/home IP). Update this if your IP changes."
  type        = string
}

variable "ec2_instance_connect_cidr" {
  description = "AWS EC2 Instance Connect service CIDR for this region (browser-based console SSH)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  default     = "SwiftChange Integration"
  type        = string

}

variable "ami_id" {
  description = "AMI ID"
  default     = "ami-084b17e3cb2d02a6c"
  type        = string
}