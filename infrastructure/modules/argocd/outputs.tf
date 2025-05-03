data "aws_eks_cluster_auth" "this" {
  name = var.k8s_cluster_name #"staging-eks-cluster"
}
output "argocd_namespace" {
  value = kubernetes_namespace.argocd.metadata[0].name
}

data "kubernetes_service" "argocd_server" {
  metadata {
    name      = "argocd-server"
    namespace = "argocd"
  }
  depends_on = [helm_release.argocd]
}


output "argocd_server_host" {
  value = data.kubernetes_service.argocd_server.status[0].load_balancer[0].ingress[0].hostname
  depends_on = [data.kubernetes_service.argocd_server]
}

output "argocd_server_password" {
  value = data.aws_secretsmanager_secret_version.password.secret_string
  sensitive = true
}

output "argocd_server_namespace" {
  value = kubernetes_namespace.argocd.metadata[0].name
}