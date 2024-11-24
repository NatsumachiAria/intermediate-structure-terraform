variable "aws_region" {
  default = "ap-southeast-1"
}

variable "env_prefix" {
  // This variable is received value from user.
  description = "specific environment"
  default     = "dev"
}

variable "private_subnets" {
  description = "private_subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "rds_private_subnets" {
  description = "rds_private_subnets"
  type        = list(string)
  default     = ["10.0.100.0/24", "10.0.101.0/24", "10.0.102.0/24"]
}

variable "public_subnets" {
  description = "private_subnets"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
}

variable "ap-southeast-1-azs" {
  description = "availability_zone"
  type        = list(string)
  default     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}