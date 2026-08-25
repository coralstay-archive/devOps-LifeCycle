# ml-training-pipeline

**카테고리**: ML/AI
**설명**: SageMaker 기반 모델 학습 파이프라인.

## 상태

composed — `s3-bucket`(모델 아티팩트 저장)+`step-functions`(오케스트레이션 뼈대) 조합, `terraform validate` 통과. `sagemaker` 모듈의 README에 적었듯, SageMaker 학습 작업 자체는 지속적인 Terraform 리소스가 아니라 SDK/`step-functions`로 트리거하는 잡(job)이라 여기 포함하지 않았다 — `orchestration`의 `definition`을 실제 학습 워크플로(SageMaker 학습 작업 시작 → 대기 → 모델 등록)로 채울 것.

## 관련 모듈

s3-bucket, step-functions

## 참고자료

- 관련 모듈 문서: `s3-bucket`, `step-functions` (`sagemaker` 모듈 문서의 SageMaker 개발자 안내서도 참고)
