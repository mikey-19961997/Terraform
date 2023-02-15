resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = "mikey-vpc"
  }
}

resource "aws_subnet" "firstsubnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.sub_cidr_block1
  tags = {
    Name = "subnet1"
  }
}

resource "aws_subnet" "secondsubnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.sub_cidr_block2
  tags = {
    Name = "subnet2"
  }
}

resource "aws_subnet" "thirdsubnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.sub_cidr_block3
  tags = {
    Name = "subnet3"
  }
}

resource "aws_subnet" "fourthsubnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.sub_cidr_block4
  tags = {
    Name = "subnet4"
  }
}