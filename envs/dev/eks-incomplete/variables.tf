variable "aws_region" {
  default = "ap-southeast-1"
}

variable "env_prefix" {
  // This variable is received value from user.
  description = "specific environment"
  default     = "dev"
}

variable "eks-private-subnet" {
  type    = list(string)
  default = ["10.0.32.0/19", "10.0.64.0/19", "10.0.96.0/19"]
}

variable "eks-public-subnet" {
  type    = list(string)
  default = ["10.0.128.0/19", "10.0.160.0/19", "10.0.192.0/19"]
}

variable "ap-southeast-1-azs" {
  description = "availability_zone"
  type        = list(string)
  default     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}