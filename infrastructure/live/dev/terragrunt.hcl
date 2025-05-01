#  Recommened to have Terraform state files in a remote backend.
# Steps to get this configuration working:
# 1. Create an S3 bucket for Terraform state files. versioning on. private bucket
# 2. Create a DynamoDB table for state locking (optional but recommended). LockID as partition key.
locals {
  environment = basename(dirname(find_in_parent_folders()))
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "mababio-terraform-state"  # <-- replace with your actual bucket
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"  # <-- optional locking
  }
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  backend "s3" {}
}
EOF
}
