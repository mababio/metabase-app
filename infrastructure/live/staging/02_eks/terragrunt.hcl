terraform {
  source = "../../../modules/eks"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../01_vpc"
}

inputs = {
  cluster_name             = dependency.vpc.outputs.cluster_name # important that this matches the eks cluster name. if not issue with ingress-nginx
  # "staging-eks-cluster"
  kubernetes_version       = "1.29"  # or latest available
  subnet_ids               =  dependency.vpc.outputs.public_subnets # replace with outputs from VPC
  # ["subnet-12345", "subnet-67890"] # replace with outputs from VPC
  # cluster_role_arn         = "arn:aws:iam::123456789012:role/EKSClusterRole" # replace
  # node_role_arn            = "arn:aws:iam::123456789012:role/EKSNodeRole" # replace
  node_group_desired_size  = 1
  node_group_min_size      = 1
  node_group_max_size      = 2
  instance_types           = ["t3.medium"]
  disk_size                = 20
}