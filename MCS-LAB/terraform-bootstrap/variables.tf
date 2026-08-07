variable "aws_region" {
  description = "AWS Region where resources will be created"
  type        = string
}

variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "environment" {
  description = "Deployment Environment"
  type        = string
}

variable "bucket_name" {
  description = "Terraform State S3 Bucket Name"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Terraform State Lock Table Name"
  type        = string
}




