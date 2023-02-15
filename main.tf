resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = "mikey-vpc"
  }
}

resource "aws_subnet" "firstsubnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.sub_cidr_block
  tags = {
    Name = "subnet1"
  }
}
