terraform {
  source = "../../../modules/argo-manage"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "eks" {
  config_path = "../02_eks"
}


dependency "argo" {
  config_path = "../argo"
}


# Define input variables for the Terraform module
inputs = {
  k8s_host         = dependency.eks.outputs.k8s_host
  k8s_token        = dependency.eks.outputs.k8s_token
  k8s_cluster_ca_certificate = dependency.eks.outputs.k8s_cluster_ca_certificate
  argocd_admin_password = dependency.argo.outputs.argocd_server_password
  argocd_host         = dependency.argo.outputs.argocd_server_host
}