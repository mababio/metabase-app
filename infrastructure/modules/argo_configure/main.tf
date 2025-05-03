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
