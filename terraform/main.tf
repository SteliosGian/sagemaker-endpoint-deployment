provider "aws" {
  region  = var.aws_region
}

locals {
  # Common tags to be assigned to all resources
  tags = {
    owner       = var.owner
  }
  s3_bucket              = "sg-sagemaker-endpoint-deployment"
  lambda_hash_key        = "lambdas/lambda_function.txt"
  lambda_zip_key         = "lambdas/lambda_function.zip"
  model_dir              = "/opt/ml/model"
  model_s3_uri           = "s3://sg-sagemaker-endpoint-deployment/deployments/multilingual-e5-small/"
  endpoint_instance_type = "ml.c5.4xlarge"
  model_name = "embeddings-model"
}

# S3 Bucket should be in-place with the embeddings model already in it
data "aws_s3_bucket" "s3_bucket" {
  bucket = local.s3_bucket
}
