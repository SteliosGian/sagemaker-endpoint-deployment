resource "aws_iam_policy" "ecr_repository_access" {
  name        = "ecr_repository_access"
  description = "ECR Repo Access for Sagemaker Model"
  policy      = templatefile("policy/ecr_policy.tpl", { S3_BUCKET_ARN = data.aws_s3_bucket.s3_bucket.arn })

  tags = local.tags
}

data "aws_iam_policy_document" "sagemaker_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }

}

resource "aws_iam_role_policy_attachment" "attach_ecr_repository_access" {
  policy_arn = aws_iam_policy.ecr_repository_access.arn
  role       = aws_iam_role.ecr_sagemaker_access.name
}

resource "aws_iam_role" "ecr_sagemaker_access" {
  name               = "sagemaker_ecr_model_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.sagemaker_assume_role_policy.json

  tags = local.tags
}
