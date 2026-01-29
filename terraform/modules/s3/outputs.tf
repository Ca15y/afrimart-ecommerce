# modules/s3/outputs.tf
output "bucket_id" {
  value = aws_s3_bucket.this.id
}

