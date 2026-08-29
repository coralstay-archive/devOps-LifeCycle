# serverless-api

**카테고리**: 웹/API
**설명**: API Gateway+Lambda+DynamoDB 기반 서버리스 API.

## 상태

composed — `dynamodb`, `lambda`, `api-gateway` 조합, `terraform validate` 통과. `src/handler.py`에 실제로 동작하는 최소 핸들러(200 응답)를 넣어뒀고 `archive_file` 데이터 소스로 자동 zip한다 — 별도 빌드 스텝 없이 바로 apply 가능.

## 관련 모듈

dynamodb, lambda, api-gateway

## 참고자료

- [AWS 백서: Serverless Multi-Tier Architectures with API Gateway and Lambda](https://docs.aws.amazon.com/whitepapers/latest/serverless-multi-tier-architectures-api-gateway-lambda/welcome.html)
- 관련 모듈 문서: `lambda`, `dynamodb`, `api-gateway`

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_name"></a> [name](#input\_name) | Base name for the DynamoDB table, Lambda function, and API Gateway HTTP API. | `string` | `"serverless-api"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_api_endpoint"></a> [api\_endpoint](#output\_api\_endpoint) | Invoke URL for the HTTP API's auto-deployed $default stage. |
<!-- END_TF_DOCS -->