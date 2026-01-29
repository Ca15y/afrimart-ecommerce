resource "aws_eip" "this" {
  domain = "vpc"

  tags = {
    Name = "${var.project}-${var.env}-eip"
  }
}

resource "aws_eip_association" "this" {
  instance_id   = aws_instance.this.id
  allocation_id = aws_eip.this.id
}


