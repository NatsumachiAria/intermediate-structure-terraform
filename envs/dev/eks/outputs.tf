output "eks-private-subnets" {
  description = "private_subnets"
  value       = aws_subnet.eks-private-subnets[*].id
}

output "eks-public-subnets" {
  description = "public_subnets"
  value       = aws_subnet.eks-public-subnets[*].id
}