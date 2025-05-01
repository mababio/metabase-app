resource "argocd_application" "metabase" {
  metadata {
    name      = "metabase"
    namespace = "argocd"
  }

  spec {
    source {
      repo_url        = "https://github.com/mababio/metabase-app.git"
      path            = "helm/charts/metabase-app" # Adjust path to your Helm chart
      target_revision = "HEAD"
      helm {
        # atomic = true # Enable Helm atomic operations for auto-rollback
        value_files = ["values.yaml"]
      }
    }

    destination {
      server    = var.k8s_host
      namespace = "metabase"
    }

    sync_policy {
      automated {
        prune     = true # Delete old resources
        self_heal = true # Automatically correct drift
      }
      sync_options = ["CreateNamespace=true"]
    }
  }
}