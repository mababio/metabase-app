terraform {
  source = "../../../modules/ingress-nginx"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "eks" {
  config_path = "../02_eks"
}


# Define input variables for the Terraform module
inputs = {
  name             = "ingress-nginx"
  namespace        = "ingress-nginx"
  chart_version    = "4.12.1"
  image_tag        = "1.12.1"
  replica_count    = 2
  k8s_host         = dependency.eks.outputs.k8s_host
  k8s_token        = dependency.eks.outputs.k8s_token
  k8s_cluster_ca_certificate = dependency.eks.outputs.k8s_cluster_ca_certificate
}