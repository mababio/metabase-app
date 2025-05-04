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

## Next Steps
This app is in staging POC stage. Here are some important things we need to do before we can deploy this app to production:
- Find out a way to inject secrets into the app. We can use AWS Secrets Manager in some capacity. Right now, we have encrypted secrets in the repo. This is not ideal.
- Stress test metabase application. Get a baseline of performance.
- Create a architecture diagram of the infrastructure and application.
- Ensure environments are separated.
- At some point come up with a disaster recovery plan. IAC is great start. but expand on that. EKS master nodes across multiple AZs.
- domain name for the app. We can use AWS Route 53 to create a domain name for the app.
- ssl certificate for the app. We can use AWS Certificate Manager to create a ssl certificate for the app.
- monitoring and logging for the app. We can use Prometheus and Grafana for monitoring and logging. We can also use AWS CloudWatch for monitoring and logging.
- think of some alerts SLOs and SLAs for the app. 
- Setup meeting with stakeholders to discuss the app and get feedback.
- Move from public k8s  control panel to private k8s control panel. This is a security risk. Anyone can see metadata of k8s cluster.
- 