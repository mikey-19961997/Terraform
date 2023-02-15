resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = "mikey-vpc"
  }
}

resource "aws_subnet" "subnets" {
  count = 5
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.sub_cidr_block(count.index)
  
  tags = {
    Name = var.sub_name{count.index)}
  }
}

