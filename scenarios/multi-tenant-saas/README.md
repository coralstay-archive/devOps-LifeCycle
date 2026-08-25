# multi-tenant-saas

**카테고리**: 웹/API
**설명**: 테넌트별 리소스/네임스페이스 격리가 필요한 SaaS 패턴.

## 상태

composed — `vpc`+`eks`+`rds-postgres`+`observability` 조합, `terraform validate` 통과. 테넌트별 격리 자체(네임스페이스, RBAC, 데이터 파티셔닝 전략)는 Kubernetes 매니페스트/애플리케이션 레이어의 몫이라 이 Terraform 조합에는 포함되지 않는다 — 여기서는 그 위에 올라갈 인프라 베이스만 제공한다.

## 관련 모듈

vpc, eks, rds-postgres, observability

## 참고자료

TBD — 추후 공식문서/책 컨텍스트로 채울 예정.
