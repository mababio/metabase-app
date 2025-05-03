

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

# provider "argocd" {
#   server_addr = outputs.argocd_server_host.value
#   # "a8d0a2deb947a46d2a84577acb14b6c4-803f33bac90cdad1.elb.us-east-1.amazonaws.com:80"
#   # "${var.argocd_host}:80"
#
#   username    = "admin"
#   # password    = var.argocd_admin_password
#   password = data.aws_secretsmanager_secret_version.password.secret_string
#   insecure    = true # If using self-signed certificate
# }
#


