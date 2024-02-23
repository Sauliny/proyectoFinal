###########################################
## Archivo de configuración de Bucket S3 ##
###########################################

## Se configura el bucket s3 para Cloudfront en AWS
resource "aws_s3_bucket" "cf-s3-ProyFinal" {
  bucket = "cfs3bucketProyFinal"

  tags = {
    Name        = "cf-s3-bucket-ProyFinal"
    Environment = "Test Saulo"
  }
}

## Se configura el acl del bucket s3 para Cloudfront en AWS
resource "aws_s3_bucket_acl" "cf-s3-acl-ProyFinal" {
  bucket = aws_s3_bucket.cf-s3-ProyFinal.id
  acl    = "private"
}

## Se configura el origin para Cloudfront en AWS
locals {
  s3_origin_id = "myS3Origin"
}