# Terraform
variable "name" {
  description = "Unique name for Terraform resources"
  type        = string
  default     = "ingress-nginx"
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

# variable "k8s_token" {
#   description = "The token of your service account"
#   type        = string
# }

variable "namespace" {
  description = "The Kubernetes namespace"
  type        = string
  default     = "ingress-nginx"
}

# ingress-nginx
variable "chart_version" {
  description = "The Helm Chart version"
  type        = string
  default     = "4.4.0"
}

variable "image_tag" {
  description = "The image tag"
  type        = string
  default     = "v1.5.1"
}


variable "static_ip_name" {
    description = "The name of the static IP"
    type        = string
    default     = "static-ip-nginx-ingress"
}

variable "static_ip_region" {
    description = "The region of the static IP"
    type        = string
    default     = "us-central1"
}

variable "enable_static_ip" {
    description = "Enable static IP"
    type        = bool
    default     = false
}

# variable "project_id" {
#     description = "The project ID"
#     type        = string
# }

variable "replica_count" {
    description = "The number of replicas"
    type        = number
    default     = 1
}
