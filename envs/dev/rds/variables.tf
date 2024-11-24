variable "aws_region" {
  default = "ap-southeast-1"
}

variable "env_prefix" {
  description = "specific environment"
  default     = "dev"
}

variable "ap-southeast-1-azs" {
  description = "availability_zone"
  type        = list(string)
  default     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}
