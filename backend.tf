##################################################################
## Archivo de configuración de Bucket S3 para proyecto Final SE ##
## backend.tf                                                   ##
##################################################################
terraform {
  backend "s3" {
    bucket = "bucketTfstateProyFinal"
    key    = "bucketTfstateProyFinal.tfstate"
    region = "us-east-1"
  }
}
