terraform {
  backend "s3" {
    bucket         = "swiftchange-tfstate-610489687511"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "swiftchange-terraform-lock"
    encrypt        = true
  }
}