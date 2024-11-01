data "terraform_remote_state" "subnet" {
  // Set data block to use remote state backend in local
  // Index point to VPC folder remote state backend
  backend = "local"
  config = {
    path = "../subnet/terraform.tfstate"
  }
}