###############################################################
## Archivo de Configuración de conexión hacia la Nube de AWS ##
## proveedor.tf                                              ##
###############################################################
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.37.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
