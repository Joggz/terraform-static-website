output "s3_endpoint" {
    value = module.s3_bucket.s3_endpoint
}


output "cloudfront_origin_access_identity" {
  value = module.cloudfront.cloudfront_origin_access_identity
}