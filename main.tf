resource "aws_vpc" "myvpc" {
    cidr_block = "192.168.0.0/16"
    tags = {
        Name = "mikey-vpc"
    }
}

resource "aws_subnet" "firstsubnet" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "192.168.1.0/24"
    tags = {
        Name = "subnet1"
    }
}

resource "aws_instance" "prac" {
    ami = "ami-0557a15b87f6559cf"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.firstsubnet.id
    associate_public_ip_address = true
    key_name = "geethu"
    tags = {
        Name = "mikey-1"
    }
}