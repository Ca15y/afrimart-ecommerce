# modules/vpc/variables.tf
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "private_subnets_cidrs" {
  type    = list(string)
  default = ["10.0.101.0/24","10.0.102.0/24"]
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a","us-east-1b"]
}

variable "project" { type = string }
variable "env"     { type = string }

