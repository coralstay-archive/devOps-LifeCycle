resource "aws_iam_role" "this" {
  name = "${var.name}-sagemaker-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "sagemaker.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
}

resource "aws_sagemaker_model" "this" {
  name               = var.name
  execution_role_arn = aws_iam_role.this.arn

  primary_container {
    image          = var.container_image
    model_data_url = var.model_data_url
  }

  tags = var.tags
}

resource "aws_sagemaker_endpoint_configuration" "this" {
  name = "${var.name}-config"

  production_variants {
    variant_name           = "primary"
    model_name             = aws_sagemaker_model.this.name
    instance_type          = var.instance_type
    initial_instance_count = var.initial_instance_count
  }

  tags = var.tags

  lifecycle {
    precondition {
      condition     = var.initial_instance_count >= 1
      error_message = "initial_instance_count must be at least 1."
    }
  }
}

resource "aws_sagemaker_endpoint" "this" {
  name                 = var.name
  endpoint_config_name = aws_sagemaker_endpoint_configuration.this.name

  tags = var.tags
}
