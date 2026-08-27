# A thin pass-through onto the sagemaker module — this scenario exists
# mainly to give "real-time inference" its own entry point/README distinct
# from ml-training-pipeline, even though the underlying module call is
# almost the whole scenario.
module "endpoint" {
  source = "../../modules/sagemaker"

  name            = var.name
  container_image = var.container_image
  model_data_url  = var.model_data_url
}
