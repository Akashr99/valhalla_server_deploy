provider "aws" {
  region = "ap-south-1"
}

# VPC
resource "aws_vpc" "valhalla_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "valhalla-vpc"
  }
}

# Subnet
resource "aws_subnet" "valhalla_subnet" {
  vpc_id     = aws_vpc.valhalla_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "valhalla-subnet"
  }
}

# Security Group
resource "aws_security_group" "valhalla_sg" {
  vpc_id = aws_vpc.valhalla_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22  # Example: Allow SSH
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Add more ingress rules as needed for Valhalla server
}

# EC2 Instance
resource "aws_instance" "valhalla_instance" {
  ami             = "ami-06c9aa07816a50ec1"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.valhalla_subnet.id
  security_groups  = [aws_security_group.valhalla_sg.id]
  key_name        = "linux new"

  # Additional configuration for the instance
  tags = {
    Name = "valhalla-instance"
  }
}
                                                  
