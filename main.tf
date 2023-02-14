resource "aws_vpc" "myvpc" {
    cidr_block = "192.168.0.0/16"
    enable_dns_hostnames = true
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

resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/24"
    gateway_id = aws_internet_gateway.my-igw.id
  }
}

resource "aws_route_table_association" "my-art" {
  subnet_id      = aws_subnet.firstsubnet.id
  route_table_id = aws_route_table.my-rt.id
}

resource "aws_security_group" "my-sg" {
  vpc_id      = aws_vpc.myvpc.id
  tags = {
    Name = "mikey-sg"
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "mike-igw"
  }
}

resource "aws_instance" "prac" {
    ami = "ami-0557a15b87f6559cf"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.firstsubnet.id
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.my-sg.id]
    key_name = "mikey"
    tags = {
        Name = "mikey-1"
    }
}