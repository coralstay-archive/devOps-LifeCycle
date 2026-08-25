# real-time-streaming

**카테고리**: 데이터/스트리밍
**설명**: MSK(Kafka)와 컨슈머 애플리케이션으로 실시간 스트림 처리.

## 상태

composed — `vpc`+`msk-kafka`+`observability` 조합, `terraform validate` 통과. 컨슈머 애플리케이션 자체(ECS/Lambda 등)는 포함하지 않음 — `ecs-service` 또는 `lambda` 모듈을 추가해서 이 카프카 클러스터를 구독하게 할 것.

## 관련 모듈

vpc, msk-kafka, observability

## 참고자료

TBD — 추후 공식문서/책 컨텍스트로 채울 예정.
