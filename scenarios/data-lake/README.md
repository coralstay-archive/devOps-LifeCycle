# data-lake

**카테고리**: 데이터/스트리밍
**설명**: S3+Glue+Athena로 구성하는 데이터 레이크.

## 상태

composed — `s3-bucket`+`glue`+`athena` 조합, `terraform validate` 통과. 버킷의 `raw/` 프리픽스를 크롤러가 스캔하고, `athena-results/` 프리픽스로 쿼리 결과가 나간다.

## 관련 모듈

s3-bucket, glue, athena

## 참고자료

- [AWS 백서: Storage Best Practices for Data and Analytics Applications — 데이터 레이크 기초](https://docs.aws.amazon.com/whitepapers/latest/building-data-lakes/data-lake-foundation.html)
- 관련 모듈 문서: `s3-bucket`, `glue`, `athena`
