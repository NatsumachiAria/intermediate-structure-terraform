output "eks-private-subnets" {
  description = "private_subnets"
  value       = aws_subnet.eks-private-subnets[*].id
}

output "eks-public-subnets" {
  description = "public_subnets"
  value       = aws_subnet.eks-public-subnets[*].id
}

output "eks-cluster-name" {
  // terraform docs use the "ID" attribute to show the cluster name
  value = aws_eks_cluster.demo.id
}

output "eks-cluster-arn" {
  value = aws_eks_cluster.demo.arn
}

output "eks-cluster-id" {
  value = aws_eks_cluster.demo.cluster_id
}

output "eks_cluster_autoscaler_arn" {
  value = aws_iam_role.eks_cluster_autoscaler.arn
}