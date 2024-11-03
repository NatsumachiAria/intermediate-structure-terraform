output "dev_vpc_id" {
  description = "DEV VPC ID"
  value       = aws_vpc.dev-vpc.id
}

output "dev-igw-id" {
  description = "dev-igw-id"
  value       = aws_internet_gateway.dev-igw.id
}

output "dev-nat-gw-id" {
  description = "dev-nat-gw"
  value       = aws_nat_gateway.dev-nat-gw.id
}

output "public-asso-ip-id" {
  description = "This subnet is created for attached with NAT Gateway purpose only."
  value       = aws_subnet.public_asso_ip.id
}