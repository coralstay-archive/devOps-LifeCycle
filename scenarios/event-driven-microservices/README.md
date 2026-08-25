# event-driven-microservices

**카테고리**: 이벤트/메시징
**설명**: SNS/SQS+Lambda 기반 이벤트 드리븐 마이크로서비스.

## 상태

composed — `sns-sqs`(토픽→큐)+`lambda`(SQS 이벤트 소스 매핑으로 컨슈밍) 조합, `terraform validate` 통과. `src/handler.py`에 최소 컨슈머 로직 포함.

## 관련 모듈

sns-sqs, lambda

## 참고자료

TBD — 추후 공식문서/책 컨텍스트로 채울 예정.
