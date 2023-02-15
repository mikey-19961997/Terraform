region = "us-east-2"

vpc_details = {
    Name = "mikey-vpc"
    cidr_block = "192.168.0.0/16"
}

subnet_details = {
    Name = ["mikey1","mikey2","mikey3","mikey4"]
}