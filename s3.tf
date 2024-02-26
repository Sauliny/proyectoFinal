###########################################
## Archivo de configuración de Bucket S3 ##
###########################################

## Se configura el bucket s3 para Cloudfront en AWS
resource "aws_s3_bucket" "cf-s3-proyfinal" {
  bucket = "cfs3bucket-proyfinal"

  tags = {
    Name        = "cf-s3-bucket-ProyFinal"
    Environment = "Test Saulo"
  }
}

## Se configura el aws_s3_bucket_policy para Cloudfront en AWS

# resource "aws_s3_bucket_policy" "bucket_policy_py" {
#   bucket = aws_s3_bucket.cf-s3-proyfinal.id
#   policy = aws_iam_policy_document.policy_docu_pf.json
# }

/*
## Revisar este codigo: DATA
data "aws_iam_policy_document" "policy_docu_pf" {
  policy_id = "PolicyForCloudFrontPrivateContent"
  version   = "2008-10-17"
  statement {
    sid     = "AllowCloudFrontServicePrincipal"
    effect  = "Allow"
    actions = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.cf-s3-proyfinal.arn}/*"]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values = [aws_cloudfront_distribution.s3_distribution.arn]
    }
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
  }
}
*/

## Se configura el acl del bucket s3 para Cloudfront en AWS
resource "aws_s3_bucket_acl" "cf-s3-acl-proyfinal" {
  bucket = data.aws_s3_bucket.cf-s3-proyfinal.id
  acl    = "private"
}
resource "aws_s3_bucket_public_access_block" "public_access_block_aws_s3" {
  bucket = aws_s3_bucket.cf-s3-proyfinal.id
  
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

## Se configura el origin para Cloudfront en AWS
locals {
  s3_origin_id = "myS3Origin"
#  s3_origin_id = "myS3Origin"
}
