#!/bin/bash

echo "=== AfriMart Setup Debug ==="
echo ""

echo "1. Checking kubectl connection..."
kubectl cluster-info || echo "❌ kubectl not connected to cluster"
echo ""

echo "2. Checking namespaces..."
kubectl get namespaces | grep production || echo "❌ production namespace not found"
echo ""

echo "3. Checking Terraform state..."
cd terraform
terraform state list | grep -E "(rds|elasticache)" || echo "❌ RDS/Redis not in Terraform state"
echo ""

echo "4. Getting Terraform outputs..."
echo "Database:"
terraform output database_endpoint || echo "❌ Database endpoint not available"
echo ""
echo "Redis:"
terraform output redis_endpoint || echo "❌ Redis endpoint not available"
echo ""

echo "5. Checking AWS resources directly..."
echo "RDS Instances:"
aws rds describe-db-instances --query 'DBInstances[?DBInstanceIdentifier==`afrimart-dev-db`].Endpoint.Address' --output text
echo ""
echo "ElastiCache Clusters:"
aws elasticache describe-cache-clusters --query 'CacheClusters[?CacheClusterId==`afrimart-dev-redis`].CacheNodes[0].Endpoint.Address' --output text
echo ""

echo "6. Checking secrets in Kubernetes..."
kubectl get secrets -n production 2>/dev/null || echo "❌ Cannot access production namespace"
echo ""

echo "=== Debug Complete ==="
