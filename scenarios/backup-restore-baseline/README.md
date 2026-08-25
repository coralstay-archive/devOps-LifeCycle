# backup-restore-baseline

**카테고리**: 가용성/재해복구
**설명**: AWS Backup 기반 정기 백업/복구 정책 baseline.

## 상태

composed — `vpc`+`rds-postgres`+`aws-backup`(RDS를 매일 백업, 35일 보관 기본값) 조합, `terraform validate` 통과. `disaster-recovery-pilot-light`와 리소스 구성은 겹치지만 목적이 다르다 — 여긴 "백업 정책 자체"가 핵심이고, 그쪽은 "페일오버 준비 상태"가 핵심.

## 관련 모듈

vpc, rds-postgres, aws-backup

## 참고자료

TBD — 추후 공식문서/책 컨텍스트로 채울 예정.
