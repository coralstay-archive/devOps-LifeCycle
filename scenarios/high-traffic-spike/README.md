# high-traffic-spike

**카테고리**: 웹/API
**설명**: 구글/스포티파이급 급격한 트래픽 스파이크에 대응하는 구성.

## 상태

composed — `vpc`, `eks`, `elasticache-redis`, `msk-kafka`, `observability` 조합, `terraform validate` 통과.

**알려진 제약**: `eks` 모듈이 아직 노드 보안그룹을 출력하지 않아서, redis/kafka의 `allowed_security_group_ids`를 자동으로 연결하지 못했다 — 배포 후 EKS 노드 보안그룹을 수동으로 redis/kafka 보안그룹에 추가해야 실제로 통신 가능하다. Karpenter도 `eks` 모듈 자체의 제약으로 아직 없음(해당 모듈 README 참고).

## 관련 모듈

vpc, eks, elasticache-redis, msk-kafka, observability

## 참고자료

TBD — 추후 공식문서/책 컨텍스트로 채울 예정.
