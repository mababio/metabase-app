terraform {
  required_providers {
    argocd = {
      source = "oboukili/argocd"
      version = "6.2.0" # Check for the latest version
    }
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

provider "argocd" {
  server_addr = "${var.argocd_host}:80"
  # "a8d0a2deb947a46d2a84577acb14b6c4-803f33bac90cdad1.elb.us-east-1.amazonaws.com:80"

  username    = "admin"
  password    = var.argocd_admin_password
  insecure    = true # If using self-signed certificate
}
