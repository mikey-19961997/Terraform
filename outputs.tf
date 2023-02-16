output "vpc_id" {
    value = aws_vpc.myvpc.id
}

output "vpc_name" {
    value = aws_vpc.myvpc.tags
}

output "subnets" {
    value = aws_subnet.subnets.cidrsubnet(var.vpc_details.cidr_block,8,count.index)
}