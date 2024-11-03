/* data "terraform_remote_state" "subnet" {
  // Retrieve expose info from subnet folder. 
  // Set data block to use remote state backend in local
  // Index point to subnet folder remote state backend
  backend = "local"
  config = {
    path = "../subnet/terraform.tfstate"
  }
}

data "terraform_remote_state" "eks" {
  // Retrieve expose info from eks folder. 
  // Set data block to use remote state backend in local
  // Index point to eks folder remote state backend
  backend = "local"
  config = {
    path = "../eks/terraform.tfstate"
  }
} */