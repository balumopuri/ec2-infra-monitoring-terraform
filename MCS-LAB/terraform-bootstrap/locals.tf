locals {
  common_tags = {
    Organization = "IAG Cargo"
    Application  = "SwiftChange"
    Project      = var.project_name
    Environment  = var.environment
    Team         = "MCS"
    ManagedBy    = "Terraform"
    Owner        = "DevOps"
  }
}