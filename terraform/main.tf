# terraform/main.tf
module "vpc" {
  source                = "./modules/vpc"
  vpc_cidr              = "10.0.0.0/16"
  public_subnets_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
  azs                   = var.azs
  project               = var.project
  env                   = var.env
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = "${var.project}-${var.env}-uploads-bucket-${random_string.suffix.result}"
  project     = var.project
  env         = var.env
}

resource "random_string" "suffix" {
  length  = 6
  upper   = false
  numeric = true
  special = false
}

module "ec2" {
  source       = "./modules/ec2"
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.public_subnet_ids
  project      = var.project
  env          = var.env
  cidr_allowed = var.cidr_allowed
  ssh_key_name = var.ssh_key_name
  ami_id       = var.ami_id
}

module "rds" {
  source             = "./modules/rds"
  private_subnet_ids = module.vpc.private_subnet_ids
  project            = var.project
  env                = var.env
  db_password        = var.db_password
}


