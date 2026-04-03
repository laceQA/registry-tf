resource "aws_iam_role" "sagemaker_role" {
  name = "sagemaker-execution-role-testlace"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "sagemaker.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "policy" {
  role       = aws_iam_role.sagemaker_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
}

resource "aws_sagemaker_model" "this" {
  name               = var.model_name
  execution_role_arn = aws_iam_role.sagemaker_role.arn

  primary_container {
    image = var.image

    environment = {
      HF_MODEL_ID = var.model_id
      HF_TASK     = "text-classification"
    }
  }
}

resource "aws_sagemaker_endpoint_configuration" "this" {
  name = "${var.model_name}-config"

  production_variants {
    variant_name           = "AllTraffic"
    model_name             = aws_sagemaker_model.this.name
    instance_type          = "ml.t2.medium"
    initial_instance_count = 1
  }
}

resource "aws_sagemaker_endpoint" "this" {
  name                 = var.endpoint_name
  endpoint_config_name = aws_sagemaker_endpoint_configuration.this.name
}