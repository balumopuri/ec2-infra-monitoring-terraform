terraform {
    required_version = ">=1.5.0"

    required_providers {
      aws = {
        source = "harshicorp/aws"
        version = "~> 6.0"
      }
    }
}