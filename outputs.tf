output "vpc_id" {
    value = aws_vpc.myvpc.id
}

output "vpc_name" {
    value = aws_vpc.myvpc.tags
}

output "subnets" {
    value = aws_subnet.subnets.cidr_block
}