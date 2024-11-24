output "private_subnets" {
  description = "private_subnets"
  value       = aws_subnet.private_subnets[*].id
}

output "rds_private_subnets" {
  description = "rds_private_subnets"
  value       = aws_subnet.rds_private_subnets[*].id
}

output "public_subnets" {
  description = "public_subnets"
  value       = aws_subnet.public_subnets[*].id
}