resource "aws_vpc" "myvpc" {
    cidr_block = "192.168.0.0/16"
    tags = {
        Name = "mikey-vpc"
    }
}

resource "aws_subnet" "firstsubnet" {
    vpc.id = aws_vpc.myvpc.id
    cidr_block = "192.168.1.0/24"
}