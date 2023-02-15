resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_details.cidr_block
  tags = {
    Name = var.vpc_details.Name
  }
}

resource "aws_subnet" "subnets" {
  count = length(var.subnet_details.Name)
  vpc_id = aws_vpc.myvpc.id
  cidr_block = cidrsubnet(var.vpc_details.cidr_block,8,count.index)
  tags = {
    Name = var.subnet_details.Name[count.index]
  }
}