variable "aws_region" {
  default = "ap-southeast-1"
}

variable "env_prefix" {
  // This variable is received value from user.
  description = "specific environment"
  default     = "dev"
}

variable "eks-private-subnets" {
  description = "eks-private-subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "eks-public-subnets" {
  description = "eks-public-subnets"
  type        = list(string)
  default     = ["10.0.111.0/24", "10.0.112.0/24", "10.0.113.0/24"]
}

variable "ap-southeast-1-azs" {
  description = "availability_zone"
  type        = list(string)
  default     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}