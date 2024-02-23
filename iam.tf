############################################
## Archivo de configuración de IAM Policy ##
############################################

data "aws_iam_policy_document" "s3_iam_policy_ProyFinal" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.cf-s3-ProyFinal.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.OAI_ProyFinal.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "s3_bucket_policy_ProyFinal" {
  bucket = aws_s3_bucket.cf-s3-ProyFinal.id
  policy = data.aws_iam_policy_document.s3_iam_policy_ProyFinal.json
}