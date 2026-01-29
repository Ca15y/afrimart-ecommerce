# modules/ec2/main.tf
resource "aws_security_group" "instance_sg" {
  name        = "${var.project}-${var.env}-instance-sg"
  description = "Allow SSH/HTTP/HTTPS from allowed CIDR"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_allowed]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Jenkins UI"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.project}-${var.env}-instance-sg" }
}

resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = element(var.subnet_ids, 0)
  key_name                    = var.ssh_key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.instance_sg.id]
  tags = {
    Name = "${var.project}-${var.env}-instance"
  }

  # minimal user-data to install python (so ansible's raw module works)
  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y python3
              EOF
}

