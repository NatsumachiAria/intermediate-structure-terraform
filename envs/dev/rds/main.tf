resource "aws_rds_cluster" "postgresql" {
  cluster_identifier        = "postgresql-cluster-demo"
  engine                    = "postgres"
  engine_version            = "16.2"
  db_cluster_instance_class = "db.m5d.large"
  storage_type              = "io1"
  allocated_storage         = 100
  iops                      = 1000
  availability_zones        = var.ap-southeast-1-azs
  database_name             = "my_demo_cluster"
  master_username           = "postgres"
  master_password           = "m;u4ymiN"
  vpc_security_group_ids    = [aws_security_group.postgres-sg.id]
  db_subnet_group_name      = aws_db_subnet_group.mydb_subnet_group.name
  storage_encrypted         = true
  skip_final_snapshot       = true
}

resource "aws_rds_cluster_instance" "postgresql_instance" {
  identifier          = "postgresql-instance"
  cluster_identifier  = aws_rds_cluster.postgresql.id
  instance_class      = "db.m5d.large"
  engine              = aws_rds_cluster.postgresql.engine
  engine_version      = aws_rds_cluster.postgresql.engine_version
  publicly_accessible = true
}

resource "aws_db_subnet_group" "mydb_subnet_group" {
  name       = "mydb-subnet-group"
  subnet_ids = data.terraform_remote_state.dev-subnet.outputs.rds_private_subnets
  tags = {
    Name = "MyDBSubnetGroup"
  }
}

resource "aws_security_group" "postgres-sg" {
  vpc_id      = data.terraform_remote_state.dev-vpc.outputs.dev_vpc_id
  name        = "postgres-sg"
  description = "Security group for RDS Aurora"

  ingress {
    description = "postgres/postgres"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}