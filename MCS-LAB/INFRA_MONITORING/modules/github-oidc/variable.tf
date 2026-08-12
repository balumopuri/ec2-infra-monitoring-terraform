# ==========================================================
# Application
# ==========================================================

variable "application_name" {
  description = "Application name"
  type        = string
}


# ==========================================================
# Environment
# ==========================================================

variable "environment" {
  description = "Environment name"
  type        = string
}


# ==========================================================
# GitHub Organization / User
# ==========================================================

variable "github_org" {
  description = "GitHub organization or username"
  type        = string
}


variable "github_org_id" {
  description = "GitHub organization or user immutable ID"
  type        = string
}


# ==========================================================
# GitHub Repository
# ==========================================================

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}


variable "github_repo_id" {
  description = "GitHub repository immutable ID"
  type        = string
}


# ==========================================================
# GitHub Branch
# ==========================================================

variable "github_branch" {
  description = "GitHub branch allowed to assume the IAM role"
  type        = string
  default     = "main"
}


# ==========================================================
# GitHub Environment
# ==========================================================

variable "github_environment" {
  description = "GitHub Environment name allowed to assume the IAM role (used by jobs with an `environment:` key, e.g. the apply job)"
  type        = string
  default     = "production"
}


# ==========================================================
# Common Tags
# ==========================================================

variable "common_tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}


# ==========================================================
# Terraform Backend
# ==========================================================

variable "aws_region" {
  description = "AWS region the Terraform state backend lives in"
  type        = string
}


variable "state_bucket_name" {
  description = "S3 bucket name storing Terraform state"
  type        = string
}


variable "state_key" {
  description = "S3 object key (path) for this environment's Terraform state file, e.g. dev/terraform.tfstate"
  type        = string
}


variable "dynamodb_table_name" {
  description = "DynamoDB table name used for Terraform state locking"
  type        = string
}