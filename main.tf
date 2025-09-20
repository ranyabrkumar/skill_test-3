terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = var.aws_region
}

# Get latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  owners = ["amazon"]
}

#  default VPC
data "aws_vpc" "default" {
  default = true
}

# Fetch all default subnets in that VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Pick the first subnet [by default default subnet is public subnet in each AZ]
data "aws_subnet" "default" {
  id = tolist(data.aws_subnets.default.ids)[0]
}


# Security group for EC2 & app
resource "aws_security_group" "app_sg" {
  name        = "tf-ecom-sg-rbrk"
  description = "Allow frontend HTTP and internal service ports"
  vpc_id      = data.aws_vpc.default.id

  # Allow SSH (change var.my_ip_cidr if needed)
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Public HTTP
  ingress {
    description = "HTTP to frontend"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "frontend services"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Internal service ports 3001-3004 allowed within same SG
  ingress {
    description = "Internal services"
    from_port   = 3001
    to_port     = 3004
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "tf-ecom-sg" }
}

# EC2 instance to run all containers
resource "aws_instance" "app" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnet.default.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.app_sg.id]
  key_name                    = var.key_name

  tags = { Name = "tf-ecom-app-instance-rbrk" }

  user_data = templatefile("${path.module}/user-data.tpl", {
    dockerhub_user        = var.dockerhub_user
    dockerhub_pass        = var.dockerhub_pass
    dockerhub_repo_prefix = var.dockerhub_repo_prefix
  })
}
