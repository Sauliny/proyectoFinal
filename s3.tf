###########################################
## Archivo de configuración de Bucket S3 ##
###########################################

resource "aws_s3_bucket" "cf-s3-ProyFinal" {
  bucket = "cfs3bucketProyFinal"

  tags = {
    Name        = "cf-s3-bucket-ProyFinal"
    Environment = "Test Saulo"
  }
}

resource "aws_s3_bucket_acl" "cf-s3-acl-ProyFinal" {
  bucket = aws_s3_bucket.cf-s3-ProyFinal.id
  acl    = "private"
}
locals {
  s3_origin_id = "myS3Origin"
}
