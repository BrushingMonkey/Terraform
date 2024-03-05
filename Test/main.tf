terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name = "MyTerraformVPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
}

resource "aws_instance" "Ubuntu" {
  ami = data.aws_ami.automatic_ami.id
  instance_type = var.instance_type
  user_data = "${file(userdata-nginx.sh)}"
  
}

resource "aws_instance" "redhat" {
  ami = var.redhat_ami.id
  instance_type = var.instance_type
  user_data = "${file(user_data-apache.sh)}"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "omers-S3-Bucket"

  tags = {
    Name        = "My bucket"
  }
}

resource "aws_s3_bucket_object" "file" {
  bucket = aws_s3_bucket.bucket.id
  key = "s3.txt"
  source = "Test/s3.txt"
}

resource "aws_security_group" "security_group" {
  name = "project security group"
  description = "allow ports inbound"
  vpc_id = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.allow_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}