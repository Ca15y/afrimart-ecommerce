# modules/rds/variables.tf
variable "private_subnet_ids" { type = list(string) }
variable "project" { type = string }
variable "env"     { type = string }

variable "allocated_storage" { 
 type = number
 default = 20
 }
variable "engine_version"    {
 type = string
 default = "13"
 }
variable "instance_class"    { 
type = string 
default = "db.t3.micro"
 }

variable "db_name"     { 
type = string
 default = "afrimartdb" 
}
variable "db_username" {
 type = string
 default = "afrimart"
 }
variable "db_password" {
  description = "Database master password - pass via tfvars or secrets"
  type        = string
  sensitive     = true
}

