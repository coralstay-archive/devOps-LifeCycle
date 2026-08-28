# sagemaker

Real-time inference endpoint (model + endpoint config + endpoint) for `ml-realtime-inference`. Uses the broad `AmazonSageMakerFullAccess` managed policy for simplicity — scope down for anything beyond experimentation.

## Status

Implemented (minimal): inference endpoint only.

## Not yet included

Training pipelines (`ml-training-pipeline`) aren't a persistent Terraform resource in the usual sense — SageMaker training jobs are typically kicked off via the SDK/`step-functions`, not declared as long-lived infra. Orchestrate training with the `step-functions` module instead of expecting a Terraform resource here.

**Endpoint storage encryption is opt-in** (`endpoint_kms_key_arn`) — unlike S3/DynamoDB/SNS, SageMaker has no AWS-managed-key fallback for the inference storage volume; pass a KMS key ARN (e.g. from the `kms` module) when a scenario needs encryption at rest.

## 런타임 불변식 (precondition/postcondition)

`aws_sagemaker_endpoint_configuration.this`에 `precondition`을 달아, `initial_instance_count`가 1 이상인지 검증한다.

## 공식문서

- [Amazon SageMaker 개발자 안내서](https://docs.aws.amazon.com/sagemaker/latest/dg/whatis.html)
- Terraform: [`aws_sagemaker_endpoint`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_endpoint)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | ECR image URI serving the model | `string` | n/a | yes |
| <a name="input_endpoint_kms_key_arn"></a> [endpoint\_kms\_key\_arn](#input\_endpoint\_kms\_key\_arn) | KMS key ARN to encrypt the endpoint's inference storage volume at rest (e.g. from the kms module). Leave null to skip — SageMaker has no AWS-managed-key fallback here, so this volume is genuinely unencrypted without one. | `string` | `null` | no |
| <a name="input_initial_instance_count"></a> [initial\_instance\_count](#input\_initial\_instance\_count) | Number of instances behind the endpoint's production variant. Must be at least 1 -- enforced by this module's precondition. | `number` | `1` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type backing the endpoint's production variant (e.g. ml.t2.medium, ml.m5.large). | `string` | `"ml.t2.medium"` | no |
| <a name="input_model_data_url"></a> [model\_data\_url](#input\_model\_data\_url) | S3 URI of the packaged model artifact (model.tar.gz) | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Base name for the SageMaker model, endpoint configuration, endpoint, and IAM role. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to the model, endpoint configuration, endpoint, and IAM role. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_endpoint_name"></a> [endpoint\_name](#output\_endpoint\_name) | Name of the live, invokable SageMaker endpoint -- pass this to application code calling for predictions. |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | ARN of the IAM role SageMaker assumes to run the model/endpoint (AmazonSageMakerFullAccess attached). |
<!-- END_TF_DOCS -->
