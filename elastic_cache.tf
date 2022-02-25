###############################################
#  ELASTICACHE SUBNET GROUP                   #
###############################################

resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "example-subnet-group"
  subnet_ids = [aws_subnet.subnet05.id, aws_subnet.subnet06.id]
}

###############################################
#  ELASTICACHE REDIS SETTTING                 #
###############################################

resource "aws_elasticache_replication_group" "example" {
  automatic_failover_enabled    = true
  replication_group_id          = "tf-rep-group-1"
  replication_group_description = "test description"
  node_type                     = "cache.t2.micro"
  number_cache_clusters         = 2
  parameter_group_name          = "default.redis6.x"
  port                          = 6379
  subnet_group_name             = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids            = [aws_security_group.elasticache.id]
}
