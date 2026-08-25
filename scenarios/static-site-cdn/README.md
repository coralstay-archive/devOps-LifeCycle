# static-site-cdn

**카테고리**: 웹/API
**설명**: S3+CloudFront+Route53으로 정적 사이트 배포.

## 상태

composed — `s3-bucket`+`cloudfront`를 OAC(Origin Access Control)로 연결하고 버킷 정책까지 포함, `terraform validate` 통과. Route53 커스텀 도메인은 포함하지 않음(기본 CloudFront 도메인 사용) — 커스텀 도메인이 필요하면 `route53`+`acm` 모듈을 추가하고 `cloudfront` 모듈의 `certificate_arn`/`aliases`를 채울 것.

## 관련 모듈

s3-bucket, cloudfront

## 참고자료

TBD — 추후 공식문서/책 컨텍스트로 채울 예정.
