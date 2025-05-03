# 🚀 GitOps-Based Deployment Pipeline on AWS EKS

## Overview

This project demonstrates a fully automated GitOps CI/CD pipeline for deploying a containerized application to an AWS Elastic Kubernetes Service (EKS) cluster.
It uses
- Terraform for infrastructure provisioning
- Along with the terraform wrapper Terragrunt
- Helm for Kubernetes package management
- Argo CD for GitOps-based continuous delivery.



## ✅ Prerequisites

- AWS CLI configured

- Terraform 1.3+

- kubectl

- Helm 3.x

- Docker

- Argo CD CLI (optional)
- K9s (optional)


## 🛠 Setup Instructions

###  Provision Infrastructure with Terraform/terragrunt



   
  #### 1.  _Update `infrastructure/live/staging/terragrunt.hcl` with bucket name and table name._
   _We will be using s3 bucket for remote state management.
   Make sure to create a bucket in the region you want to deploy. And DynamoDB table for state locking._


#### 2. For each sub folder in `infrastructure/live/staging`, do the following:
     - review terragrunt.hcl to update values or read speccial instructions
     ```bash
          terragrunt init
          terragrunt apply 

Once you `terragrunt apply` all the `terragrunt.hcl` files, you will have the following resources created:

- VPC with public and private subnets
- EKS cluster
- EKS node group
- IAM roles and policies for EKS
- S3 bucket for remote state management
- DynamoDB table for state locking
- RDS Postgres database
- Ingress controller (NGINX)
- Argo CD instance that configures itself to sync with this Git repository.



Update your kubeconfig:

aws eks --region <region> update-kubeconfig --name <cluster_name>

2. Install Argo CD in the EKS Cluster

kubectl create namespace argocd
helm repo add argo https://argoproj.github.io/argo-helm
helm install argocd argo/argo-cd -n argocd

Expose the Argo CD UI:

kubectl port-forward svc/argocd-server -n argocd 8080:443

Access: https://localhost:8080

Get the initial admin password:

kubectl -n argocd get secret argocd-initial-admin-secret \
-o jsonpath="{.data.password}" | base64 -d && echo

3. Bootstrap GitOps with Argo CD

kubectl apply -f argo/app.yaml

This configures Argo CD to sync your application's manifests from the Git repository.

4. Deploy the Sample Microservice

Modify values in helm/my-app/values.yaml if needed. The Helm chart is synced by Argo CD automatically via app.yaml.

Manual deployment (optional):

helm upgrade --install my-app helm/my-app -n default

5. Simulate a Deployment Failure

Trigger a failure by pushing bad config (e.g., typo in container image name):

image:
repository: my-app
tag: non-existent-tag

Push this to Git and observe Argo CD or Argo Rollouts handle the rollback.

🔄 Blue/Green Deployment with Argo Rollouts (Extra Credit)

To enable blue/green:

Replace Deployment with Rollout in the Helm chart

Use Argo Rollouts controller

Configure analysis templates, steps, and traffic routing

Install Argo Rollouts:

kubectl apply -n default -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml

Visualize rollout:

kubectl argo rollouts dashboard

📄 Documentation & Design Choices

See docs/DESIGN.md (optional) for:

Why Terraform and Argo CD were chosen

IAM roles and networking design

Failure handling and rollback strategy

🔪 Testing

terraform validate and terraform plan for IaC validation

Simulated image deployment failure for rollback

Argo CD sync status for GitOps deployment

Validate exposed service with curl or browser

📙 References

Terraform AWS Provider

Argo CD Docs

Argo Rollouts

Helm Docs

