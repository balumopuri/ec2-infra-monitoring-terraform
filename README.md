# ec2-infra-monitoring-terraform
# Provision EC2 + enable CloudWatch Agent monitoring using Terraform, deployed via GitHub Actions CI/CD.

terraform-bootstrap/
│
├── .github/
│   └── workflows/
│       └── terraform.yml              # (We'll add later)
│
├── backend.tf                         # Remote backend configuration
├── versions.tf                        # Terraform & provider versions
├── provider.tf                        # AWS provider configuration
├── variables.tf                       # Input variables
├── terraform.tfvars                   # Variable values
├── locals.tf                          # Common tags and local values
│
├── s3.tf                              # S3 Backend Resources
├── dynamodb.tf                        # DynamoDB Lock Table
│
├── outputs.tf                         # Outputs
├── README.md                          # Documentation
├── .gitignore
├── .terraform.lock.hcl                # Auto-generated (Commit this)
│
└── terraform.tfstate                  # Present now (will move to S3)