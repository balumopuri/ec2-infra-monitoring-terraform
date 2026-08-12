# ==========================================================
# AWS Account Information
# ==========================================================

data "aws_caller_identity" "current" {}


# ==========================================================
# GitHub Actions OIDC Provider
# ==========================================================

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  tags = merge(
    var.common_tags,
    {
      Name = "${var.application_name}-${var.environment}-github-oidc"
    }
  )
}


# ==========================================================
# IAM Role for GitHub Actions
# ==========================================================

resource "aws_iam_role" "github_actions" {
  name = "${var.application_name}-${var.environment}-github-actions-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }

        Action = "sts:AssumeRoleWithWebIdentity"

        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"

            "token.actions.githubusercontent.com:sub" = [
              "repo:${var.github_org}@${var.github_org_id}/${var.github_repo}@${var.github_repo_id}:ref:refs/heads/${var.github_branch}",
              "repo:${var.github_org}@${var.github_org_id}/${var.github_repo}@${var.github_repo_id}:environment:${var.github_environment}"
            ]
          }
        }
      }
    ]
  })

  tags = merge(
    var.common_tags,
    {
      Name = "${var.application_name}-${var.environment}-github-actions-role"
    }
  )
}


# ==========================================================
# Terraform Backend Permissions
# ==========================================================

resource "aws_iam_role_policy" "terraform_backend" {
  name = "${var.application_name}-${var.environment}-terraform-backend"

  role = aws_iam_role.github_actions.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [

      # ----------------------------------------------------
      # S3 Terraform State
      # ----------------------------------------------------

      {
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]

        Resource = "arn:aws:s3:::${var.state_bucket_name}/${var.state_key}"
      },

      {
        Effect = "Allow"

        Action = [
          "s3:ListBucket"
        ]

        Resource = "arn:aws:s3:::${var.state_bucket_name}"
      },

      # ----------------------------------------------------
      # DynamoDB Terraform State Lock
      # ----------------------------------------------------

      {
        Effect = "Allow"

        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem"
        ]

        Resource = "arn:aws:dynamodb:${var.aws_region}:${data.aws_caller_identity.current.account_id}:table/${var.dynamodb_table_name}"
      }
    ]
  })
}