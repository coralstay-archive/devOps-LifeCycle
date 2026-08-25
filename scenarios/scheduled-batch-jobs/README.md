# scheduled-batch-jobs

**카테고리**: 이벤트/메시징
**설명**: EventBridge+ECS/Batch로 스케줄된 배치 작업 실행.

## 상태

composed — `lambda`+`eventbridge`(기본 1시간 주기) 조합, `terraform validate` 통과. ECS/Batch 대신 Lambda로 구현했다 — 작업이 15분(Lambda 최대 실행시간)을 넘기거나 컨테이너가 필요하면 `ecs-service`를 EventBridge 타겟으로 바꿀 것.

## 관련 모듈

lambda, eventbridge

## 참고자료

TBD — 추후 공식문서/책 컨텍스트로 채울 예정.
