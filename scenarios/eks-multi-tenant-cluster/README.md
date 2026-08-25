# eks-multi-tenant-cluster

**카테고리**: 컨테이너/배포전략
**설명**: 네임스페이스 기반으로 여러 팀/서비스가 공유하는 EKS 클러스터.

## 상태

composed — `vpc`+`eks`(노드 3~6대로 여유 확보)+`observability` 조합, `terraform validate` 통과. 네임스페이스별 RBAC/리소스 쿼터는 Kubernetes 매니페스트 레이어의 몫이라 여기 포함하지 않았다.

## 관련 모듈

vpc, eks, observability

## 참고자료

TBD — 추후 공식문서/책 컨텍스트로 채울 예정.
