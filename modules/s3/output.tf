output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.static_site.bucket
  
}

output "bucket_regional_domain_name" {
  description = "The regional domain name of the S3 bucket"
  value       = aws_s3_bucket.static_site.bucket_regional_domain_name
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.static_site.arn
}


output "s3_endpoint" {
  value = aws_s3_bucket_website_configuration.static_site
}

