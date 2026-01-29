# terraform/variables.tf
variable "aws_region" {
  description = "us-east-1"
  type        = string
  default     = "us-east-1"
}

variable "project" {
  description = "afrimart-ecommerce"
  type        = string
  default     = "afrimart"
}

variable "env" {
  description = "staging"
  type        = string
  default     = "staging"
}

variable "cidr_allowed" {
  description = "0.0.0.0/0"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ssh_key_name" {
  description = "project-key"
  type        = string
  default     = "project-key"
}

# terraform/variables.tf (extend earlier global vars)
variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "ami_id" {
  description = "AMI ID to use for EC2 instances"
  type        = string
  default     = "ami-07ff62358b87c7116" # replace as necessary
}

variable "db_password" {
  description = "DB password for RDS instance (override in tfvars)"
  type        = string
  sensitive   = true
}


