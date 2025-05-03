# Make sure to create the secret in AWS Secrets Manager with the name "argocd-password1" and the appropriate password.
# for example, you can use the following command to create a password:
# echo -n 'mypassword' | htpasswd -BinC 10 '' | cut -d ":" -f 2 --> take this output string and use it as the password

# aws secretsmanager create-secret \
# --name metabase-db-password \
# --secret-string 'changeMe123!'

terraform {
  source = "../../../modules/argocd"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "eks" {
  config_path = "../02_eks"
}


# Define input variables for the Terraform module
inputs = {
  namespace        = "argocd"
  chart_version    = "7.9.0"
  k8s_host         = dependency.eks.outputs.k8s_host
  k8s_token        = dependency.eks.outputs.k8s_token
  k8s_cluster_ca_certificate = dependency.eks.outputs.k8s_cluster_ca_certificate
  aws_managed_secret_id = "argocd-password1"
  k8s_cluster_name = dependency.eks.outputs.cluster_name
}