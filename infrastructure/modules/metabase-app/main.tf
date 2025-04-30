data "aws_eks_cluster_auth" "this" {
  name = "staging-eks-cluster"
}

provider "helm" {
  kubernetes {
    host                   = var.k8s_host
    token                  = data.aws_eks_cluster_auth.this.token
    cluster_ca_certificate = base64decode(var.k8s_cluster_ca_certificate)
  }
}


resource "helm_release" "metabase" {
  name       = "metabase-app"
  chart = "${path.module}/charts/metabase-app"
  namespace  = "default"
  create_namespace = false

  values = [templatefile("${path.module}/values.yaml", {
    INGRESS_HOST = var.ingress_host
    IMAGE_TAG = var.image_tag
    REPLICA_COUNT = var.replica_count
    MB_DB_USER = var.mb_db_user
    MB_DB_PASS = var.mb_db_pass
    MB_DB_HOST = var.mb_db_host
  })]
}
