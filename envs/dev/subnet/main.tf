resource "aws_subnet" "private_subnets" {
  vpc_id            = data.terraform_remote_state.dev-vpc.outputs.dev_vpc_id // Correct
  count             = length(var.private_subnets)
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.ap-southeast-1-azs[count.index]
  tags = {
    Name : "${var.env_prefix}-private-subnets-${count.index + 1}"
  }
}

resource "aws_subnet" "public_subnets" {
  vpc_id            = data.terraform_remote_state.dev-vpc.outputs.dev_vpc_id // Correct
  count             = length(var.public_subnets)
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.ap-southeast-1-azs[count.index]
  tags = {
    Name : "${var.env_prefix}-public-subnets-${count.index + 1}"
  }
}