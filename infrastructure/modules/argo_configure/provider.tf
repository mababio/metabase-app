terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.24.0"
    }
  }
}

data "aws_eks_cluster_auth" "this" {
  name = var.k8s_cluster_name
  # "staging-eks-cluster"
}

provider "kubernetes" {
  host                   = var.k8s_host
  token                  = data.aws_eks_cluster_auth.this.token
  cluster_ca_certificate = base64decode(var.k8s_cluster_ca_certificate)
}