terraform {
  source = "../../../modules/argo_configure"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "eks" {
  config_path = "../02_eks"
}


dependency "argo_server" {
  config_path = "../05_argo"
}


# Define input variables for the Terraform module
inputs = {
  argco_server_namespace        = "argocd"
  chart_version    = "7.9.0"
  k8s_token        = dependency.eks.outputs.k8s_token
  k8s_host         = dependency.eks.outputs.k8s_host
  k8s_cluster_ca_certificate = dependency.eks.outputs.k8s_cluster_ca_certificate
  aws_managed_secret_id = "argocd-password1"
  value_files = ["staging_values.yaml"]
  k8s_cluster_name = dependency.eks.outputs.cluster_name
  argocd_host = dependency.argo_server.outputs.argocd_server_host
  k8s_cluster_name = dependency.eks.outputs.cluster_name
  argco_server_namespace = dependency.argo_server.outputs.argocd_server_namespace
  source_repo_url = "https://github.com/mababio/metabase-app.git"
  repo_path = "helm/charts/metabase-app"
  # value_files = ["staging_values.yaml"]
  value_files = "staging_values.yaml"
  app_namespace = "metabase-app"
  argocd_admin_password = dependency.argo_server.outputs.argocd_server_password
  #"staging-eks-cluster"
}

