# updated resource |

resource "aws_s3_bucket" "static_site" {
    bucket = "bucket1234kurad"
    # bucket =var.bucket_name
    
}

resource "aws_s3_bucket_website_configuration" "static_site" {
    bucket = aws_s3_bucket.static_site.id

    index_document {
      suffix = "index.html"
    }

    error_document {
      key = "error.html"
    }
    
}

resource "aws_s3_bucket_ownership_controls" "static_site" {
    bucket = aws_s3_bucket.static_site.id
    rule {
        object_ownership = "BucketOwnerPreferred"
    }
    
}

resource "aws_s3_bucket_public_access_block" "static_site" {
    bucket = aws_s3_bucket.static_site.id

    block_public_acls = false
    block_public_policy = false
    ignore_public_acls = false
    
}

resource "aws_s3_bucket_acl" "static_site" {
    bucket = aws_s3_bucket.static_site.id
    depends_on = [ 
        aws_s3_bucket_ownership_controls.static_site,
        aws_s3_bucket_public_access_block.static_site
     ]
     acl = "public-read"
}


# Attach bucket policy to allow CloudFront access
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket =  aws_s3_bucket.static_site.id

  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
     aws_s3_bucket.static_site.arn,
      "${aws_s3_bucket.static_site.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_object" "files_upload" {
  for_each = fileset("modules/s3/website/", "**")
  bucket = "bucket1234kurad"
  key = each.value
  source = "modules/s3/website/${each.value}"

}




variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}






# 
# 
# 
# resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
#   bucket = aws_s3_bucket.wendy-ada-bucket.id
#   policy = data.aws_iam_policy_document.allow_access_from_another_account.json
# }

# data "aws_iam_policy_document" "allow_access_from_another_account" {
#   statement {
#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }

#     actions = [
#       "s3:GetObject",
#       "s3:ListBucket",
#     ]

#     resources = [
#       aws_s3_bucket.wendy-ada-bucket.arn,
#       "${aws_s3_bucket.wendy-ada-bucket.arn}/*",
#     ]
#   }
# }


# resource "aws_s3_bucket_website_configuration" "website" {
#     bucket = aws_s3_bucket.wendy-ada-bucket.id
    
#      index_document {
#     suffix = "index.html"
#   }
#    error_document {
#     key = "error.html"
#   }
  
# }