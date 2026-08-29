# ml-training-pipeline

**카테고리**: ML/AI
**설명**: SageMaker 기반 모델 학습 파이프라인.

## 상태

composed — `s3-bucket`(모델 아티팩트 저장)+`step-functions`(오케스트레이션 뼈대) 조합, `terraform validate` 통과. `sagemaker` 모듈의 README에 적었듯, SageMaker 학습 작업 자체는 지속적인 Terraform 리소스가 아니라 SDK/`step-functions`로 트리거하는 잡(job)이라 여기 포함하지 않았다 — `orchestration`의 `definition`을 실제 학습 워크플로(SageMaker 학습 작업 시작 → 대기 → 모델 등록)로 채울 것.

## 관련 모듈

s3-bucket, step-functions

## 참고자료

- 관련 모듈 문서: `s3-bucket`, `step-functions` (`sagemaker` 모듈 문서의 SageMaker 개발자 안내서도 참고)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_name"></a> [name](#input\_name) | Base name used as the prefix/tag for the artifacts bucket and the Step Functions state machine orchestrating the training pipeline. | `string` | `"ml-training-pipeline"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_artifacts_bucket_id"></a> [artifacts\_bucket\_id](#output\_artifacts\_bucket\_id) | S3 bucket holding training artifacts (model outputs, checkpoints). |
| <a name="output_state_machine_arn"></a> [state\_machine\_arn](#output\_state\_machine\_arn) | Step Functions state machine ARN that orchestrates the training pipeline -- use to trigger/monitor runs. |
<!-- END_TF_DOCS -->