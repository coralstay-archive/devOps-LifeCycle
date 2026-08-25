# serverless-api

**카테고리**: 웹/API
**설명**: API Gateway+Lambda+DynamoDB 기반 서버리스 API.

## 상태

composed — `dynamodb`, `lambda`, `api-gateway` 조합, `terraform validate` 통과. `src/handler.py`에 실제로 동작하는 최소 핸들러(200 응답)를 넣어뒀고 `archive_file` 데이터 소스로 자동 zip한다 — 별도 빌드 스텝 없이 바로 apply 가능.

## 관련 모듈

dynamodb, lambda, api-gateway

## 참고자료

TBD — 추후 공식문서/책 컨텍스트로 채울 예정.
