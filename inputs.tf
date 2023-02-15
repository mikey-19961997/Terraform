variable "region" {
    type = string
    default = "us-east-1"
}

variable "cidr_block" {
    type = string
    default = "10.0.0.0/16"
}

variable "sub_cidr_block" {
    type = list(string)
}

variable "sub_name" {
    type = list(string)
}

variable "azs" {
    type = list(string)
}