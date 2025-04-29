data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.this.name
}


resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn # var.cluster_role_arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  version = var.kubernetes_version

  # Optional logging
  enabled_cluster_log_types = ["api", "audit", "authenticator"]
  tags = {
    Name = var.cluster_name
  }
}

resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn = aws_iam_role.eks_node_role.arn # var.node_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.node_group_desired_size
    min_size     = var.node_group_min_size
    max_size     = var.node_group_max_size
  }

  ami_type             = "AL2_x86_64" # Amazon Linux 2
  instance_types       = var.instance_types
  disk_size            = var.disk_size
  capacity_type        = "ON_DEMAND" # or SPOT

  tags = {
    Name = "${var.cluster_name}-node-group"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_registry_readonly_policy
  ]
}
