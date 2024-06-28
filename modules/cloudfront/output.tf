output "cloudfront_distribution_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "cloudfront_distribution_hosted_zone_id" {
  description = "The hosted zone ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
}


output "cloudfront_origin_access_identity" {
 value = aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn
  # value = aws_cloudfront_origin_access_identity.origin_access_identity
}