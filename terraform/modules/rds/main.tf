# modules/rds/main.tf
resource "aws_db_subnet_group" "this" {
  name       = "${var.project}-${var.env}-db-subnet-group"
  subnet_ids = var.private_subnet_ids
  tags = { Name = "${var.project}-${var.env}-db-subnet-group" }
}

resource "aws_db_instance" "this" {
  allocated_storage    = var.allocated_storage
  engine               = "postgres"
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  db_name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  publicly_accessible  = false
  db_subnet_group_name = aws_db_subnet_group.this.name
  skip_final_snapshot  = true
  tags = { Name = "${var.project}-${var.env}-db" }
}

