# sagemaker

Real-time inference endpoint (model + endpoint config + endpoint) for `ml-realtime-inference`. Uses the broad `AmazonSageMakerFullAccess` managed policy for simplicity — scope down for anything beyond experimentation.

## Status

Implemented (minimal): inference endpoint only.

## Not yet included

Training pipelines (`ml-training-pipeline`) aren't a persistent Terraform resource in the usual sense — SageMaker training jobs are typically kicked off via the SDK/`step-functions`, not declared as long-lived infra. Orchestrate training with the `step-functions` module instead of expecting a Terraform resource here.

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | ECR image URI serving the model | `string` | n/a | yes |
| <a name="input_initial_instance_count"></a> [initial\_instance\_count](#input\_initial\_instance\_count) | n/a | `number` | `1` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"ml.t2.medium"` | no |
| <a name="input_model_data_url"></a> [model\_data\_url](#input\_model\_data\_url) | S3 URI of the packaged model artifact (model.tar.gz) | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_endpoint_name"></a> [endpoint\_name](#output\_endpoint\_name) | n/a |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | n/a |
<!-- END_TF_DOCS -->
