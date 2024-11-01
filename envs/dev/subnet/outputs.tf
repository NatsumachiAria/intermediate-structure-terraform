output "private_subnets" {
  description = "private_subnets"
  value       = aws_subnet.private_subnets[*].id
}

output "public_subnets" {
  description = "public_subnets"
  value       = aws_subnet.public_subnets[*].id
}