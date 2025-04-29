# Include the root configuration for remote state and common settings
include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/vpc"  # Reference the vpc module
}

inputs = {
  region              = "us-east-1"
  cluster_name        = "mababio-us-mobile"
  vpc_cidr            = "10.0.0.0/16"
  public_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets     = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones  = ["us-east-1a", "us-east-1b"]
}