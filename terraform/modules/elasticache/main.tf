
# Subnet group for ElastiCache
resource "aws_elasticache_subnet_group" "main" {
  name       = "${var.project}-${var.env}-redis-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name        = "${var.project}-${var.env}-redis-subnet-group"
    Environment = var.env
  }
}

# ElastiCache Redis Cluster
resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.project}-${var.env}-redis"
  engine               = "redis"
  node_type            = "cache.t3.micro"  # Free tier eligible
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  engine_version       = "7.0"
  port                 = 6379
  
  subnet_group_name  = aws_elasticache_subnet_group.main.name
  security_group_ids = [var.redis_security_group_id]

  tags = {
    Name        = "${var.project}-${var.env}-redis"
    Environment = var.env
  }
}
