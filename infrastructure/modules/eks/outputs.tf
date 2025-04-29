output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "k8s_host" {
  value = aws_eks_cluster.this.endpoint
}

output "k8s_cluster_ca_certificate" {
  value = aws_eks_cluster.this.certificate_authority[0].data
  sensitive = true
}

output "k8s_token" {
  value = data.aws_eks_cluster_auth.cluster.token
  sensitive = true
}

output "cluster_id" {
  value = aws_eks_cluster.this.id
}

output "node_group_name" {
  value = aws_eks_node_group.this.node_group_name
}