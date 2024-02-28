############################################
## Archivo de configuración de IAM Policy ##
############################################
/*
# Se crea IAM Policy Global
data "aws_iam_policy_document" "s3_iam_policy_ProyFinal" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.cf-s3-proyfinal.arn}/*"]
#    principals {
#      type        = "AWS"
#      identifiers = [aws_cloudfront_origin_access_identity.OAI_ProyFinal.iam_arn]
#    }
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.s3_distribution.arn]
    }
  }
}
*/

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
      values = ["arn:aws:cloudfront::708734958673:distribution/E7V8IIOARGCPW"]
#     values = [aws_cloudfront_distribution.s3_distribution.arn]
    }
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
  }
}

# Se crea IAM Policy para Bucket
 resource "aws_s3_bucket_policy" "s3_bucket_policy_pf" {
   bucket = aws_s3_bucket.cf-s3-proyfinal.id
   policy = data.aws_iam_policy_document.policy_docu_pf.json
   #policy = data.aws_iam_policy_document.s3_iam_policy_ProyFinal.json
}

# Se crea aws_iam_role_policy

resource "aws_iam_role_policy" "ecs_iam_role_policy" {
  name = "ecs_iam_role_policy"
  role = aws_iam_role.ecs_task_execution_role.id
  policy = jsonencode({
    Version ="2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect = "Allow"
        Resource = "*"
      },
    ]
  })
}


# Se crea ecs_task_execution_role
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "role-name"
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

# Se crea ecs_task_role
resource "aws_iam_role" "ecs_task_role" {
  name = "role-name-task" 
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

# Se crea ecs-task-execution-role-policy-attachment 
resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
#  policy_arn = "arn:aws:iam::708734958673:policy/AdministratorAccess"
}

# Se crea task_s3
# resource "aws_iam_role_policy_attachment" "task_s3" {
#   role       = "${aws_iam_role.ecs_task_role.name}"
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
# }
