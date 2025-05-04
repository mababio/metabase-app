resource "kubernetes_manifest" "metabase_app" {
  manifest = yamldecode(<<-EOF
    apiVersion: argoproj.io/v1alpha1
    kind: Application
    metadata:
      name: metabase-app
      namespace: ${var.argco_server_namespace}
    spec:
      project: default
      source:
        repoURL: ${var.source_repo_url}
        targetRevision: HEAD
        path: ${var.repo_path}
        helm:
          valueFiles:
            - ${var.value_files}
      destination:
        server: https://kubernetes.default.svc
        namespace: default
      syncPolicy:
        automated:
          prune: true
          selfHeal: true
        syncOptions:
          - CreateNamespace=true
  EOF
  )
}
provider "helm" {
  kubernetes {
    host                   = var.k8s_host
    token                  = data.aws_eks_cluster_auth.this.token
    cluster_ca_certificate = base64decode(var.k8s_cluster_ca_certificate)
  }
}

resource "helm_release" "argo_rollouts" {
  name       = "argo-rollouts"
  namespace  = "argo-rollouts"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-rollouts"
  version    = "2.39.5" # Check for latest at https://artifacthub.io/packages/helm/argo/argo-rollouts
  create_namespace = true
  values = [
    <<EOF
dashboard:
  enabled: true
EOF
  ]
}

