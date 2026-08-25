# data-warehouse

**카테고리**: 데이터/스트리밍
**설명**: Redshift 기반 데이터 웨어하우스.

## 상태

composed — `vpc`+`redshift` 조합, `terraform validate` 통과. 단일 노드 기본값이라 데이터량이 커지면 `redshift` 모듈의 `node_type`/`cluster_type`을 멀티노드로 올릴 것.

## 관련 모듈

vpc, redshift

## 참고자료

- 관련 모듈 문서: `vpc`, `redshift` (Redshift 관리 안내서 참고)
