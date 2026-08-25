# canary-deployment

**카테고리**: 컨테이너/배포전략
**설명**: 점진적 트래픽 전환 기반 카나리 배포(Argo Rollouts/App Mesh 등).

## 상태

composed — 지금은 `vpc`+`eks`+`observability`뿐인 베이스 클러스터다. `terraform validate` 통과. **카나리 배포 메커니즘(Argo Rollouts 또는 App Mesh/Istio 트래픽 분할) 자체는 아직 없음** — 이건 Helm 릴리스+CRD가 필요해서 `eks` 모듈처럼 Terraform의 `helm`/`kubernetes` provider가 있어야 하는 더 큰 작업이다. 지금은 그 위에 올라갈 클러스터만 준비된 상태.

## 관련 모듈

vpc, eks, observability

## 참고자료

TBD — 추후 공식문서/책 컨텍스트로 채울 예정.
