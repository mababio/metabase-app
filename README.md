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
