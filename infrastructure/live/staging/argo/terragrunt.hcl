terraform {
  source = "../../../modules/argocd"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "eks" {
  config_path = "../02_eks"
}


# Define input variables for the Terraform module
inputs = {
  namespace        = "argocd"
  chart_version    = "7.9.0"
  # chart_version    = "7.8.15"
  k8s_host         = dependency.eks.outputs.k8s_host
  k8s_token        = dependency.eks.outputs.k8s_token
  k8s_cluster_ca_certificate = dependency.eks.outputs.k8s_cluster_ca_certificate
  aws_managed_secret_id = "argocd-password1"
}