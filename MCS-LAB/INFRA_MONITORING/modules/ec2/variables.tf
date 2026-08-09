variable "application_name" {
  description = "Application name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will be launched"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID for the EC2 instance"
  type        = string
}

variable "instance_profile_name" {
  description = "IAM Instance Profile name"
  type        = string
}

variable "common_tags" {
  description = "Common resource tags"
  type        = map(string)
}

variable "user_data" {
  description = "Bootstrap script executed when the EC2 instance starts"
  type        = string
  default     = null
}