############################################################
## Archivo de configuración de ECR para proyecto Final SE ##
## ECR (Elastic Container Regisytry)                      ##
## ecr.tf                                                 ##
############################################################

resource "aws_ecr_repository" "ecr-proyfinal" {
  name                 = "registry-proyfinal"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}
/*
output "demo_app_repo_url" {
  value = aws_ecr_repository.ecrProyFinal.repository_url
}
*/