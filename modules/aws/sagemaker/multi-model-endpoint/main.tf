resource "aws_sagemaker_model" "this" {
  name               = "${var.endpoint_name}-mme"
  execution_role_arn = var.execution_role_arn

  primary_container {
    image = var.image

    mode = "MultiModel"

    model_data_url = var.s3_model_path
  }
}

resource "aws_sagemaker_endpoint_configuration" "this" {
  name = "${var.endpoint_name}-config"

  production_variants {
    variant_name           = "AllTraffic"
    model_name             = aws_sagemaker_model.this.name
    instance_type          = var.instance_type
    initial_instance_count = 1
  }
}

resource "aws_sagemaker_endpoint" "this" {
  name                 = var.endpoint_name
  endpoint_config_name = aws_sagemaker_endpoint_configuration.this.name
}