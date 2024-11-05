# IAM role for eks

resource "aws_iam_role" "demo" {
  name = "eks-cluster-demo"
  tags = {
    tag-key = "eks-cluster-demo"
  }

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "eks.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

# eks policy attachment

resource "aws_iam_role_policy_attachment" "demo-AmazonEKSClusterPolicy" {
  role       = aws_iam_role.demo.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# bare minimum requirement of eks

resource "aws_eks_cluster" "demo" {
  name     = "demo"
  role_arn = aws_iam_role.demo.arn

  vpc_config {
       subnet_ids = concat("${aws_subnet.eks-private-subnets[*].id}", "${aws_subnet.eks-public-subnets[*].id}")
    /* subnet_ids = [
      "${aws_subnet.eks-private-subnets[*].id}",
      aws_subnet.eks-private-subnets-1.id,
      aws_subnet.eks-private-subnets-2.id,
      aws_subnet.eks-private-subnets-3.id,
      aws_subnet.eks-public-subnets-1.id,
      aws_subnet.eks-public-subnets-2.id,
      aws_subnet.eks-public-subnets-3.id 
      "${aws_subnet.eks-public-subnets[*].id}"
    ] */
  }

  depends_on = [aws_iam_role_policy_attachment.demo-AmazonEKSClusterPolicy]
}