data "aws_secretsmanager_secret_version" "password" {
  secret_id = var.aws_managed_secret_id

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

    password = data.aws_secretsmanager_secret_version.password.secret_string
  })
  ]
  depends_on = [kubernetes_namespace.argocd]
}

