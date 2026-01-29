# modules/ec2/variables.tf
variable "vpc_id" { type = string }
variable "subnet_ids" { type = list(string) }
variable "project" { type = string }
variable "env" { type = string }
variable "cidr_allowed" { type = string }
variable "ssh_key_name" { type = string }
variable "ami_id" {
  description = "AMI ID - choose Amazon Linux 2 or Ubuntu in your region"
  type        = string
  default     = "ami-0c02fb55956c7d316" # example Ubuntu 20.04 LTS in us-east-1 (replace if different region)
}
variable "instance_type" {
  type    = string
  default = "t3.micro"
}


