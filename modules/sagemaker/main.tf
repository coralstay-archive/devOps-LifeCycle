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

# Broad managed policy for simplicity — scope this down to just the S3
# paths/ECR repos the model actually needs once this is more than
# experimentation.
resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
}

# Describes WHAT to serve: a container image + model artifact location.
# SageMaker splits "what to serve" (model), "how many/what size" (endpoint
# configuration, below), and "the live thing" (endpoint) into three separate
# resources rather than one — this lets you reuse one model across multiple
# endpoint configs.
resource "aws_sagemaker_model" "this" {
  name               = var.name
  execution_role_arn = aws_iam_role.this.arn

  primary_container {
    image          = var.container_image
    model_data_url = var.model_data_url
  }

  tags = var.tags
}

# Describes HOW to serve it: instance type/count. Kept separate from the
# model itself so you could point a new endpoint config at the same model
# with different scaling, without redefining the model.
resource "aws_sagemaker_endpoint_configuration" "this" {
  name = "${var.name}-config"

  production_variants {
    variant_name           = "primary"
    model_name             = aws_sagemaker_model.this.name
    instance_type          = var.instance_type
    initial_instance_count = var.initial_instance_count
  }

  tags = var.tags

  # Zero instances would mean the endpoint config describes a variant that
  # can never actually serve a request.
  lifecycle {
    precondition {
      condition     = var.initial_instance_count >= 1
      error_message = "initial_instance_count must be at least 1."
    }
  }
}

# The actual live, invokable endpoint — this is what application code
# actually calls to get a prediction.
resource "aws_sagemaker_endpoint" "this" {
  name                 = var.name
  endpoint_config_name = aws_sagemaker_endpoint_configuration.this.name

  tags = var.tags
}
