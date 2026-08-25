# ml-realtime-inference

**카테고리**: ML/AI
**설명**: SageMaker 엔드포인트로 실시간 추론 서비스 제공.

## 상태

composed — `sagemaker` 모듈을 그대로 노출. `container_image`/`model_data_url`은 프로젝트마다 다를 수밖에 없어 기본값 없이 필수 입력으로 뒀다 — `terraform validate`는 통과하지만(값이 있든 없든 타입 체크만 하므로), 실제 apply 전에 반드시 채워야 한다.

## 관련 모듈

sagemaker

## 참고자료

TBD — 추후 공식문서/책 컨텍스트로 채울 예정.
