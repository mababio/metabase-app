terraform {
  required_version = ">= 1.0.4"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "=2.23.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "=2.11.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}
