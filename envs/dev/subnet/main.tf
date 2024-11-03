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
  vpc_id                  = data.terraform_remote_state.dev-vpc.outputs.dev_vpc_id // Correct
  count                   = length(var.public_subnets)
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.ap-southeast-1-azs[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name : "${var.env_prefix}-public-subnets-${count.index + 1}"
  }
}


// Route table Public 
resource "aws_route_table" "dev-public-rtb" {
  vpc_id = data.terraform_remote_state.dev-vpc.outputs.dev_vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.terraform_remote_state.dev-vpc.outputs.dev-igw-id
  }
  tags = {
    Name = "${var.env_prefix}-public-rtb"
  }
}

resource "aws_route_table_association" "public-asso-rtb" {
  // Add subnet "public-asso-ip" to "dev-public-rtb"
  subnet_id      = data.terraform_remote_state.dev-vpc.outputs.public-asso-ip-id
  route_table_id = aws_route_table.dev-public-rtb.id
}

// Route table Public associated
resource "aws_route_table_association" "public-rtb-asc" {
  //for_each       = toset(aws_subnet.public_subnets[*].id)
  //for_each       = toset(var.public_subnets)
  //subnet_id      = each.value
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.dev-public-rtb.id
}

// Route table Private 
resource "aws_route_table" "dev-private-rtb" {
  vpc_id = data.terraform_remote_state.dev-vpc.outputs.dev_vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = data.terraform_remote_state.dev-vpc.outputs.dev-nat-gw-id
  }

  tags = {
    Name = "${var.env_prefix}-private-rtb"
  }
}

// Route table Private associated
resource "aws_route_table_association" "private-rtb-asc" {
  //for_each       = toset(aws_subnet.private_subnets[*].id)
  //for_each       = toset(var.private_subnets)
  //subnet_id      = each.value
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.dev-private-rtb.id
}