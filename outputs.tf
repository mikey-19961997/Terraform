output "vpc_id" {
    value = aws_vpc.myvpc.id
}

output "vpc_name" {
    value = var.vpc_details.Name
}

output "subnets" {
    value = aws_subnet.subnets
}

output "subnetcount" {
    value = length(var.subnet_details.Name)
}

output "region" {
    value = var.region
}