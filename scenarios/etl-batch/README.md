# etl-batch

**카테고리**: 데이터/스트리밍
**설명**: Step Functions+Glue 기반 배치 ETL 파이프라인.

## 상태

composed — `s3-bucket`+`glue`+`step-functions` 조합, `terraform validate` 통과. `step-functions`는 아직 기본 placeholder(Pass 상태) 정의를 쓴다 — 실제 ETL 오케스트레이션(크롤러 실행 → 후속 처리)을 짜려면 `orchestration` 모듈 호출의 `definition`을 Glue 크롤러를 실제로 호출하는 ASL로 바꾸고 `policy_arns`에 Glue 실행 권한을 추가할 것.

## 관련 모듈

s3-bucket, glue, step-functions

## 참고자료

- 관련 모듈 문서: `s3-bucket`, `glue`, `step-functions`
