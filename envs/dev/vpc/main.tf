resource "aws_vpc" "dev-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name : "${var.env_prefix}-vpc"
    Environment : "${var.env_prefix}"
  }
}

// Internet gateway
resource "aws_internet_gateway" "dev-igw" {
  vpc_id = aws_vpc.dev-vpc.id
  tags = {
    Name = "${var.env_prefix}-igw"
  }
}

// Elastic IP
resource "aws_eip" "dev-nat-eip" {
  domain = "vpc"
  tags = {
    Name : "PUBLIC-NAT-EIP"
  }
}

// NAT gateway
resource "aws_nat_gateway" "dev-nat-gw" {
  // NAT Gateway must associate with public subnet only
  // If NAT Gateway using private subnet, Resources are unable to connect internet.
  allocation_id = aws_eip.dev-nat-eip.id
  subnet_id     = aws_subnet.public_asso_ip.id
  depends_on    = [aws_internet_gateway.dev-igw]
  tags = {
    Name : "DEV-NAT-GW"
  }
}

resource "aws_subnet" "public_asso_ip" {
  // This subnet is created for attached with NAT Gateway purpose only.
  // This subnet must be located in public zone
  vpc_id            = aws_vpc.dev-vpc.id
  cidr_block        = var.public_asso_ip
  availability_zone = var.ap-southeast-1-azs[0]
  tags = {
    Name : "${var.env_prefix}-public-asso-ip"
  }
}
/* 
// Route table Public 
resource "aws_route_table" "dev-public-rtb" {
  vpc_id = aws_vpc.dev-vpc.id ////////////////////////////////
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-igw.id  /////////////////////////////
  }
  tags = {
    Name = "${var.env_prefix}-public-rtb"
  }
}

resource "aws_route_table_association" "public-asso-rtb" {
  // Add subnet "public-asso-ip" to "dev-public-rtb"
  subnet_id = aws_subnet.public_asso_ip.id               //////////////////////////////////////
  route_table_id = aws_route_table.dev-public-rtb.id     /////////////////////////////////////
}

// Route table Public associated
resource "aws_route_table_association" "public-rtb-asc" {
  for_each  = toset(data.terraform_remote_state.subnet.outputs.public_subnets)     ///////////////////////////////////
  subnet_id = each.value
  route_table_id = aws_route_table.dev-public-rtb.id                               //////////////////////////////////////////
}


// Route table Private 
resource "aws_route_table" "dev-private-rtb" {
  vpc_id = aws_vpc.dev-vpc.id     //////////////////////////////////////////

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.dev-nat-gw.id   //////////////////////////////////////
  }

  tags = {
    Name = "${var.env_prefix}-private-rtb"
  }
}

// Route table Private associated
resource "aws_route_table_association" "private-rtb-asc" {
  for_each       = toset(data.terraform_remote_state.subnet.outputs.private_subnets) //////////////////////////////////
  subnet_id      = each.value
  route_table_id = aws_route_table.dev-private-rtb.id  //////////////////////////////////////
} */