

terraform {
  required_providers {
    argocd = {
      source  = "oboukili/argocd"
      version = "6.1.1"
    }
  }
}
provider "kubernetes" {
host                   = var.k8s_host
token                  = data.aws_eks_cluster_auth.this.token
cluster_ca_certificate = base64decode(var.k8s_cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = var.k8s_host
    token                  = data.aws_eks_cluster_auth.this.token
    cluster_ca_certificate = base64decode(var.k8s_cluster_ca_certificate)
  }
}




