resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_details.cidr_block
  Name = var.vpc_details.Name
}

resource "aws_subnet" "subnets" {
  count = length(var.subnet_details.Name)
  cidr_block = cidrsubnet(var.vpc_details.cidr_block,8,count.index)
  tags = {
    Name = var.subnet_details.Name[count.index]
  }
}