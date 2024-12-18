variable "aws_region" {
  default = "ap-southeast-1"
}

variable "env_prefix" {
  description = "specific environment"
  default     = "dev"
}

variable "vpc_cidr_block" {
  description = "specific vpc cidr block"
  default     = "10.0.0.0/16"
}

variable "public_asso_ip" {
  description = "public_asso_ip" // use for public ip which associated (or reference) in public networking zone
  default     = "10.0.224.16/28"
}

variable "ap-southeast-1-azs" {
  description = "availability_zone"
  type        = list(string)
  default     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}
