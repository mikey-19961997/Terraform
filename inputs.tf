variable "region" {
    type = string
}

variable "vpc_details" {
    type = object ({
        Name = string
        cidr_block = string
    })
}

variable "subnet_details" {
    type = object ({
        Name = list(string)
    })
}