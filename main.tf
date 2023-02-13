resource "aws_vpc" "myvpc" {
    cidr_block = "192.168.0.0/16"
    tags = {
        Name = "mikey-vpc"
    }
}

resource "aws_subnet" "first-subnet" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "192.168.1.0/24"
    tags = {
        Name = "subnet1"
    }
}

resource "aws_subnet" "second-subnet" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "192.168.2.0/24"
    tags = {
        Name = "subnet2"
    }
}