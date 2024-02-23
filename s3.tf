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