# ecs-fargate-microservices

**카테고리**: 컨테이너/배포전략
**설명**: 여러 ECS Fargate 서비스로 구성된 마이크로서비스 묶음.

## 상태

composed — 공유 `vpc` 위에 `services` 변수(기본값: service-a, service-b) 개수만큼 `alb`+`ecs-service` 쌍을 `for_each`로 생성. `terraform validate` 통과. 서비스마다 별도 ALB를 쓰는 건 가장 단순한 접근이라 그렇게 했다 — ALB 비용을 아끼려면 하나의 ALB에 리스너 규칙(path/host 기반 라우팅)으로 여러 서비스를 붙이는 구조로 바꿀 수 있다(현재는 미포함).

## 관련 모듈

vpc, alb (서비스당 1개), ecs-service (서비스당 1개)

## 참고자료

TBD — 추후 공식문서/책 컨텍스트로 채울 예정.
