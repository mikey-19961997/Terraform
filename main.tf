resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = "true"
  tags = {
    Name = "mikey-vpc"
  }
}
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "mikey-igw"
  }
}
resource "aws_subnet" "subnets" {
  count = 5
  vpc_id = aws_vpc.myvpc.id
  cidr_block = cidrsubnet(10.0.0.0/16, 8, 5)
  availability_zone = var.azs[count.index]
  tags = {
    Name = var.sub_name[count.index]
  }
}
resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
}
resource "aws_route_table_association" "my-art" {
  count = 5
  subnet_id = element(aws_subnet.subnets[*].id, count.index)
  route_table_id = aws_route_table.my-rt.id
}
resource "aws_security_group" "my-sg" {
  vpc_id = aws_vpc.myvpc.id
  tags= {
    Name = "mikey-sg"
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_key_pair" "mykey" {
  key_name = "geethumikey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDO+NT3Go8C0VZlji8AsFfYgDxli78BjJeY/+QX716inzpwNOYvRF1ciDEJkeR0fz8892MmBOMOsjcQP6f9MUU4Vm0FHPnKzRpbJFgXdToWDY+KXUs7GFKS5pYyJMG8rc8meqExKb6WkVVuzO2nnk3VMQQnfkNDPQ6idGGfoh/PBXiAT1K93nYUl9+p2MLSg2glEUQA4TsPACw8YvAoQ+eQZuN3MM2uWBQC0I0TVDZ30ZidOg3H08d77muaEiB+GUbDYx4Kp3wK4uXyKySes1jKCPzyXKbQr26SyYIfT5tZ+bk4naZrV6Vn6V/KuQFAjKDzBSGXYs6gwylR4mRfapDxhdM1dQw2jHk1QM8K9IlZw06yc01jtxHlx37PzPm6NeHTlrXBJWIaueAbZA0NOAbhaWbBugyDhMHlITBR/a6JM7CwBKLba7cQGs4SYBynWsEN+I4h3AyOLzZCXXcPpzF9NEW0J2vLucSu89543icuTRzU9+Qw69B0GsI74BW6thk= mikey@LAPTOP-08N4NDS4"
}

resource "aws_instance" "myinstance" {
  count = 5
  ami = "ami-00eeedc4036573771"
  associate_public_ip_address = true
  instance_type = "t2.micro"
  key_name = aws_key_pair.mykey.id
  subnet_id = element(aws_subnet.subnets[*].id, count.index)
  vpc_security_group_ids = [aws_security_group.my-sg.id]
  tags = {
    Name = var.instance_name[count.index]
  }
}