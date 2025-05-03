## Make sure to create the secret in AWS Secrets Manager with the name "metabase-db-password" and the appropriate password.
# if you choose to name it something else, update the variable default value accordingly. aws_secret_id_postgres

# aws secretsmanager create-secret \
# --name metabase-db-password \
# --secret-string 'changeMe123!'

terraform {
  source = "../../../modules/postgres"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../01_vpc"
}



inputs = {
  db_identifier  = "metabase-postgres"
  db_name        = "metabase"
  db_username    = "metabaseuser"
  aws_secret_id_postgres = "metabase-db-password"
  vpc_id         = dependency.vpc.outputs.vpc_id
  subnet_ids     = dependency.vpc.outputs.private_subnets
  allowed_cidrs = [
    "10.0.0.0/16" # Adjust to your EKS nodes or NAT gateway CIDR range
  ]
}
