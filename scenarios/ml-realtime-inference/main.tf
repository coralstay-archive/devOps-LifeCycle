module "endpoint" {
  source = "../../modules/sagemaker"

  name            = var.name
  container_image = var.container_image
  model_data_url  = var.model_data_url
}
