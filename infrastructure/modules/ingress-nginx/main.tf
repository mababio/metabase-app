data "aws_eks_cluster_auth" "this" {
  name = "staging-eks-cluster"
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

resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = var.namespace
  }
}


resource "helm_release" "ingress_nginx" {
  name       = var.name
  namespace  = var.namespace
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = var.chart_version

  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }

  # Use NLB for static IP (automatically assigned by AWS)
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    value = "nlb"
  }

  set {
    name  = "controller.replicaCount"
    value = var.replica_count
  }

  set {
    name  = "controller.image.tag"
    value = var.image_tag
  }
}

data "kubernetes_service" "nginx_lb" {
  metadata {
    name      = "ingress-nginx-controller"
    namespace = var.namespace
  }
  depends_on = [helm_release.ingress_nginx]
}
