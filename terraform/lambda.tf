data "aws_s3_object" "lambda_zip_file" {
  bucket = data.aws_s3_bucket.s3_bucket.id
  key    = local.lambda_hash_key
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_policy" "lambda_endpoint_access" {
  name        = "lambda_endpoint_access"
  description = "Sagemaker endpoint access by lambda"
  policy      = file("policy/lambda_policy.json")

  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "attach_lambda_endpoint_access" {
  policy_arn = aws_iam_policy.lambda_endpoint_access.arn
  role       = aws_iam_role.lambda_iam_role.name
}

resource "aws_iam_role" "lambda_iam_role" {
  name               = "lambda-iam-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_lambda_function" "sagemake_invoke_lambda" {

  function_name = "croatia-sagemaker-invoke"
  role          = aws_iam_role.lambda_iam_role.arn

  s3_bucket = data.aws_s3_bucket.s3_bucket.id
  s3_key    = local.lambda_zip_key

  handler = "lambda_function.lambda_handler"

  source_code_hash = "$base64encode(data.aws_s3_object.lambda_zip_file.body)"

  runtime = "python3.10"

  timeout = 10

  environment {
    variables = {
      ENDPOINT_NAME = aws_sagemaker_endpoint.croatia_model_endpoint.name
    }
  }

  tags = local.tags
}
