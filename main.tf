module "s3_bucket" {
    source = "./modules/s3"
    bucket_name = var.bucket_name
}

 module "cloudfront" {
  source              = "./modules/cloudfront"
  origin_domain_name  = module.s3_bucket.bucket_regional_domain_name
  acm_certificate_arn = var.acm_certificate_arn
  domain_name = var.domain_name
}