variable "bucket_name" {
    description = "mybucketkonradass"
    type = string
}


variable "acm_certificate_arn" {
    type = string
    description = "(optional) describe your variable"
}

variable "domain_name" {
  description = "The domain name for Route 53"
  type        = string
}