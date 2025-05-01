terraform {
  source = "../../../modules/metabase-app"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "postgres" {
  config_path = "../03_postgres"
}


dependency "eks" {
  config_path = "../02_eks"
}


# Define input variables for the Terraform module
inputs = {
  # name             = "ingress-nginx"
  # namespace        = "ingress-nginx"
  # chart_version    = "4.12.1"
  image_tag        = "v0.49.3"
  replica_count    = 1
  mb_db_user      = dependency.postgres.outputs.mb_db_user
  mb_db_pass       = dependency.postgres.outputs.mb_db_pass
  mb_db_host       = dependency.postgres.outputs.mb_db_host
  k8s_host         = dependency.eks.outputs.k8s_host
  k8s_token        = dependency.eks.outputs.k8s_token
  k8s_cluster_ca_certificate = dependency.eks.outputs.k8s_cluster_ca_certificate
}