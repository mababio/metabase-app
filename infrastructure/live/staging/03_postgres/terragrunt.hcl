terraform {
  source = "../../../modules/postgres"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../01_vpc"
}

# aws secretsmanager create-secret \
# --name metabase-db-password \
# --secret-string 'changeMe123!'
#

inputs = {
  db_identifier  = "metabase-postgres"
  db_name        = "metabase"
  db_username    = "metabaseuser"
  vpc_id         = dependency.vpc.outputs.vpc_id
  subnet_ids     = dependency.vpc.outputs.private_subnets
  allowed_cidrs = [
    "10.0.0.0/16" # Adjust to your EKS nodes or NAT gateway CIDR range
  ]
}
