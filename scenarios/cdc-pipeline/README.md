# cdc-pipeline

**카테고리**: 데이터/스트리밍
**설명**: DMS+Kafka로 데이터베이스 변경분을 캡처해 스트리밍.

## 상태

composed — `vpc`+`rds-postgres`(source)+`msk-kafka`(target)+`dms` 조합, `terraform validate` 통과.

**의도적 설계**: `rds-postgres`의 마스터 비밀번호는 Secrets Manager가 관리해 평문으로 노출되지 않는다. DMS는 literal 자격증명이 필요하므로, 마스터 계정을 재사용하지 않고 `dms_reader`라는 별도 읽기 전용 계정을 쓴다고 가정했다 — 그 계정의 비밀번호가 `source_db_password` 변수다. 실제로는 이 계정을 DB에 별도로 생성해줘야 한다(이 모듈 조합만으로는 생성되지 않음).

## 관련 모듈

vpc, rds-postgres, msk-kafka, dms

## 참고자료

- [AWS DMS 모범 사례 (CDC 포함)](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_BestPractices.html)
- 관련 모듈 문서: `vpc`, `rds-postgres`, `msk-kafka`, `dms`
