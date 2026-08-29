# ml-realtime-inference

**카테고리**: ML/AI
**설명**: SageMaker 엔드포인트로 실시간 추론 서비스 제공.

## 상태

composed — `sagemaker` 모듈을 그대로 노출. `container_image`/`model_data_url`은 프로젝트마다 다를 수밖에 없어 기본값 없이 필수 입력으로 뒀다 — `terraform validate`는 통과하지만(값이 있든 없든 타입 체크만 하므로), 실제 apply 전에 반드시 채워야 한다.

## 관련 모듈

sagemaker

## 참고자료

- 관련 모듈 문서: `sagemaker`

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | ECR image URI serving the model — no sensible default, fill in before apply | `string` | n/a | yes |
| <a name="input_model_data_url"></a> [model\_data\_url](#input\_model\_data\_url) | S3 URI of the packaged model artifact — no sensible default, fill in before apply | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Base name used as the prefix/tag for the SageMaker model/endpoint resources. | `string` | `"ml-realtime-inference"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_endpoint_name"></a> [endpoint\_name](#output\_endpoint\_name) | SageMaker real-time inference endpoint name -- invoke it directly for predictions. |
<!-- END_TF_DOCS -->