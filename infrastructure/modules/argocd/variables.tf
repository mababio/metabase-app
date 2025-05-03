variable "namespace" {
  description = "Namespace to deploy Argo CD into"
  type        = string
  default     = "argocd"
}

variable "app_namespace" {
    description = "Namespace to deploy Argo CD applications into"
    type        = string
    default     = "metabase-app"
}

variable "chart_version" {
  description = "Version of the Argo CD Helm chart"
  type        = string
  default     = "5.51.6"
}

# Kubernetes
variable "k8s_host" {
  description = "The Kubernetes cluster server host"
  type        = string
}

variable "k8s_cluster_ca_certificate" {
  description = "Base64 encoded public CA certificate used as the root of trust for the Kubernetes cluster"
  type        = string
}

variable "aws_managed_secret_id" {
    description = "The AWS Secrets Manager secret ID"
    type        = string
}

variable "k8s_cluster_name" {
    description = "The name of the EKS cluster"
    type        = string
}
