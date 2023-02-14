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

resource "aws_main_route_table_association" "my-mrt" {
  vpc_id         = aws_vpc.myvpc.id
  route_table_id = aws_route_table.my-rt.id
}

resource "aws_default_security_group" "my-sg" {
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

resource "aws_key_pair" "my-key" {
  key_name   = "geethumikey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDO+NT3Go8C0VZlji8AsFfYgDxli78BjJeY/+QX716inzpwNOYvRF1ciDEJkeR0fz8892MmBOMOsjcQP6f9MUU4Vm0FHPnKzRpbJFgXdToWDY+KXUs7GFKS5pYyJMG8rc8meqExKb6WkVVuzO2nnk3VMQQnfkNDPQ6idGGfoh/PBXiAT1K93nYUl9+p2MLSg2glEUQA4TsPACw8YvAoQ+eQZuN3MM2uWBQC0I0TVDZ30ZidOg3H08d77muaEiB+GUbDYx4Kp3wK4uXyKySes1jKCPzyXKbQr26SyYIfT5tZ+bk4naZrV6Vn6V/KuQFAjKDzBSGXYs6gwylR4mRfapDxhdM1dQw2jHk1QM8K9IlZw06yc01jtxHlx37PzPm6NeHTlrXBJWIaueAbZA0NOAbhaWbBugyDhMHlITBR/a6JM7CwBKLba7cQGs4SYBynWsEN+I4h3AyOLzZCXXcPpzF9NEW0J2vLucSu89543icuTRzU9+Qw69B0GsI74BW6thk= mikey@LAPTOP-08N4NDS4"
}

resource "aws_instance" "prac" {
    ami = "ami-0557a15b87f6559cf"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.firstsubnet.id
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_default_security_group.my-sg.id]
    key_name = "geethumikey"
    tags = {
        Name = "mikey-1"
    }
}