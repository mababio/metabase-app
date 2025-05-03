# Kubernetes
variable "k8s_host" {
  description = "The Kubernetes cluster server host"
  type        = string
  default = "https://kubernetes.default.svc"
}

variable "k8s_cluster_ca_certificate" {
  description = "Base64 encoded public CA certificate used as the root of trust for the Kubernetes cluster"
  type        = string
}

variable "argocd_host" {
    description = "The Argo CD server host"
    type        = string
}

variable "k8s_cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "argco_server_namespace" {
    description = "Namespace to deploy Argo CD into"
    type        = string
    default     = "argocd"
}

###

variable "source_repo_url" {
    description = "The source repository URL"
    type        = string
}
 variable "repo_path" {
    description = "The path to the Helm chart in the repository"
    type        = string
 }

variable "value_files" {
    description = "List of value files for Helm chart"
    type        = list(string)
    default     = ["values.yaml"]
}

variable "app_namespace" {
  description = "Namespace to deploy Argo CD applications into"
  type        = string
  default     = "metabase-app"
}

variable "argocd_admin_password" {
  description = "The Argo CD admin password"
  type        = string
  sensitive   = true
}

