resource "aws_subnet" "eks-private-subnet" {
  vpc_id            = data.terraform_remote_state.dev-vpc.outputs.dev_vpc_id
  count             = length(var.eks-private-subnet)
  cidr_block        = var.eks-private-subnet[count.index]
  availability_zone = var.ap-southeast-1-azs[count.index]
  tags = {
    "Name"                            = "eks-private-subnets-${count.index + 1}"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

resource "aws_subnet" "eks-public-subnet" {
  vpc_id            = data.terraform_remote_state.dev-vpc.outputs.dev_vpc_id
  count             = length(var.eks-public-subnet)
  cidr_block        = var.eks-public-subnet[count.index]
  availability_zone = var.ap-southeast-1-azs[count.index]
  tags = {
    "Name"                       = "eks-public-subnets-${count.index + 1}"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/demo" = "owned"
  }
}

// EKS Route table Public
resource "aws_route_table" "dev-eks-public-rtb" {
  vpc_id = data.terraform_remote_state.dev-vpc.outputs.dev_vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.terraform_remote_state.dev-vpc.outputs.dev-igw-id
  }
  tags = {
    Name = "${var.env_prefix}-eks-public-rtb"
  }
}

// Error occurs, due to public asso ip is used in normal public rtb
// Subnet public asso ip is created for asso with NAT GATEWAY
// TF doesn't let I use the same subnet that linked to NAT GW
/* resource "aws_route_table_association" "eks-public-asso-rtb" {
  // Add subnet "public-asso-ip" to "dev-public-rtb"
  subnet_id      = data.terraform_remote_state.dev-vpc.outputs.public-asso-ip-id
  route_table_id = aws_route_table.dev-eks-public-rtb.id
} */

// Route table Public associated
resource "aws_route_table_association" "eks-public-rtb-asc" {
  count          = length(var.eks-public-subnet)
  subnet_id      = aws_subnet.eks-public-subnet[count.index].id
  route_table_id = aws_route_table.dev-eks-public-rtb.id
}


// EKS Route table Private 
resource "aws_route_table" "dev-eks-private-rtb" {
  vpc_id = data.terraform_remote_state.dev-vpc.outputs.dev_vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = data.terraform_remote_state.dev-vpc.outputs.dev-nat-gw-id
  }

  tags = {
    Name = "${var.env_prefix}-eks-private-rtb"
  }
}

resource "aws_route_table_association" "eks-private-rtb-asc" {
  count          = length(var.eks-private-subnet)
  subnet_id      = aws_subnet.eks-private-subnet[count.index].id
  route_table_id = aws_route_table.dev-eks-private-rtb.id
}
