data "aws_eks_cluster_auth" "this" {
  name = "staging-eks-cluster"
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = var.aws_managed_secret_id

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


resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = kubernetes_namespace.argocd.metadata[0].name
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.chart_version

  values = [templatefile("${path.module}/values.yaml", {

    password = data.aws_secretsmanager_secret_version.db_password.secret_string
  })
  ]

  depends_on = [kubernetes_namespace.argocd]
}
