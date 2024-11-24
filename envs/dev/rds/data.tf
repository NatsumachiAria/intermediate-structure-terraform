data "terraform_remote_state" "dev-vpc" {
  // Set data block to use remote state backend in local
  // Index point to VPC folder remote state backend
  backend = "local"
  config = {
    path = "../vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "dev-subnet" {
  // Set data block to use remote state backend in local
  // Index point to VPC folder remote state backend
  backend = "local"
  config = {
    path = "../subnet/terraform.tfstate"
  }
}