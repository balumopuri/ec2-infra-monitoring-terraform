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
# Common Tags
# ==========================================================

variable "common_tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}