resource "aws_ecr_repository" "sagemaker_model" {
  name                 = "sagemaker-model-repo"
  image_tag_mutability = "MUTABLE"
}
