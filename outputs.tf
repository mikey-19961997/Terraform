output "vpc_id" {
    value = aws_vpc.myvpc.id
}

output "vpc_name" {
    value = aws_vpc.myvpc.tags
}