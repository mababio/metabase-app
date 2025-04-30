# Kubernetes
variable "k8s_host" {
  description = "The Kubernetes cluster server host"
  type        = string
}

variable "k8s_cluster_ca_certificate" {
  description = "Base64 encoded public CA certificate used as the root of trust for the Kubernetes cluster"
  type        = string
}