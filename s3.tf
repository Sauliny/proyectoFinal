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

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.example.id
  policy = data.aws_iam_policy_document.s3_bucket_policy.json
}


## Se configura el acl del bucket s3 para Cloudfront en AWS

resource "aws_s3_bucket_acl" "cf-s3-acl-ProyFinal" {
#  depends_on = [aws_s3_bucket_ownership_controls.bucket_controls_pf]
  bucket = aws_s3_bucket.cf-s3-proyfinal.id
  acl    = "private"
}


## Se configura el origin para Cloudfront en AWS
locals {
  s3_origin_id = "myS3Origin"
#  s3_origin_id = "myS3Origin"
}