resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "OAI for S3 bucket"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = var.origin_domain_name
    # domain_name = var.origin_domain_name
    # domain_name = aws_s3_bucket.tony1234-bucket.bucket_regional_domain_name
    # domain_name = aws_s3_bucket.bucket1234kurad.bucket_regional_domain_name
    # origin_id   = "S3-${var.origin_domain_name}"
    origin_id = "S3-bucket1234kurad"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront distribution for S3 bucket"
  default_root_object = "index.html"

# aliases = [var.custom_domain_name]

  # aliases = [var.domain_name]c
  # aliases = aws_s3_bucket.bucket1234kurad.bucket_regional_domain_name
  
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    # target_origin_id = "S3-${var.origin_domain_name}"
     target_origin_id = "S3-bucket1234kurad"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = var.acm_certificate_arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2021"
    cloudfront_default_certificate = false
  }

  tags = {
    Name = "S3-CloudFront-Distribution"
  }
}

variable "origin_domain_name" {
  description = "The domain name of the S3 bucket"
  type        = string
}

variable "acm_certificate_arn" {
  description = "The ARN of the ACM certificate"
  type        = string
}

variable "domain_name" {
  description = "The custom domain name"
  type        = string
}
