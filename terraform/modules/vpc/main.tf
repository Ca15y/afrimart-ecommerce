# modules/vpc/main.tf
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.project}-${var.env}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
  tags = { Name = "${var.project}-${var.env}-igw" }
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnets_cidrs)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnets_cidrs[count.index]
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project}-${var.env}-public-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets_cidrs)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets_cidrs[count.index]
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "${var.project}-${var.env}-private-${count.index}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags = { Name = "${var.project}-${var.env}-public-rt" }
}

resource "aws_route" "public_default" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_assoc" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# NAT Gateway (one NAT Gateway for simplicity)
resource "aws_eip" "nat" {
  domain = "vpc"
  tags = { Name = "${var.project}-${var.env}-nat-eip" }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id
  tags = { Name = "${var.project}-${var.env}-nat" }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  tags = { Name = "${var.project}-${var.env}-private-rt" }
}

resource "aws_route" "private_default" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "private_assoc" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

