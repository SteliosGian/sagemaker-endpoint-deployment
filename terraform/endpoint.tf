resource "random_id" "force_endpoint_update" {
  keepers = {
    model_name = local.model_name
  }

  byte_length = 8
}

resource "aws_sagemaker_model" "sagemaker_model" {
  depends_on = [aws_iam_role.ecr_sagemaker_access]

  name               = "embeddings"
  execution_role_arn = aws_iam_role.ecr_sagemaker_access.arn

  primary_container {
    image = "${aws_ecr_repository.sagemaker_model.repository_url}:latest"
    model_data_source {
      s3_data_source {
        s3_uri           = local.model_s3_uri
        s3_data_type     = "S3Prefix"
        compression_type = "None"
      }
    }
    environment = {
      "SM_MODEL_DIR" = local.model_dir
    }
  }

  tags = local.tags
}

resource "aws_sagemaker_endpoint_configuration" "sagemaker_endpoint_configuration" {
  name = "${local.model_name}-endpoint-config-${random_id.force_endpoint_update.dec}"

  production_variants {
    variant_name                                      = "embeddings-variant"
    model_name                                        = aws_sagemaker_model.sagemaker_model.name
    initial_instance_count                            = 1
    instance_type                                     = local.endpoint_instance_type
    container_startup_health_check_timeout_in_seconds = 300
    model_data_download_timeout_in_seconds            = 300
    # volume_size_in_gb                                 = 20
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = local.tags
}

resource "aws_sagemaker_endpoint" "sagemaker_model_endpoint" {
  name                 = "embeddings-endpoint"
  endpoint_config_name = aws_sagemaker_endpoint_configuration.sagemaker_endpoint_configuration.name

  tags = local.tags
}
