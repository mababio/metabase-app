variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for the cluster"
  type        = list(string)
}

# variable "cluster_role_arn" {
#   description = "IAM Role ARN for the EKS cluster"
#   type        = string
# }
#
# variable "node_role_arn" {
#   description = "IAM Role ARN for the EKS worker nodes"
#   type        = string
# }
#
variable "node_group_desired_size" {
  type        = number
  description = "Desired number of worker nodes"
}

variable "node_group_min_size" {
  type        = number
  description = "Minimum number of worker nodes"
}

variable "node_group_max_size" {
  type        = number
  description = "Maximum number of worker nodes"
}

variable "instance_types" {
  description = "EC2 instance types for nodes"
  type        = list(string)
}

variable "disk_size" {
  description = "Disk size for worker nodes"
  type        = number
}