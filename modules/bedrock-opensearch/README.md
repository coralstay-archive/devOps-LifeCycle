# bedrock-opensearch

Vector search backend for RAG: OpenSearch Serverless collection (public network access by default — restrict via a VPC network policy for anything beyond a quick prototype) + an IAM role Bedrock can assume to read/write it.

## Status

Implemented (minimal): OpenSearch Serverless side only.

## Not yet included

The actual `aws_bedrockagent_knowledge_base` wiring (linking a Bedrock foundation model + this collection into a queryable knowledge base) — that resource is newer/more version-sensitive in the AWS provider, added as a follow-up once `llm-rag-service` is tackled directly.

## 런타임 불변식 (precondition/postcondition)

`aws_opensearchserverless_collection.this`에 `precondition`을 달아, `name`이 OpenSearch Serverless 컬렉션 네이밍 규칙(3-32자, 소문자로 시작)을 따르는지 검증한다.

## 공식문서

- [Amazon Bedrock: 지식 기반 만들기](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-create.html)
- [OpenSearch Serverless 개발자 안내서](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless.html)
- Terraform: [`aws_opensearchserverless_collection`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearchserverless_collection)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_bedrock_role_arn"></a> [bedrock\_role\_arn](#output\_bedrock\_role\_arn) | n/a |
| <a name="output_collection_arn"></a> [collection\_arn](#output\_collection\_arn) | n/a |
| <a name="output_collection_endpoint"></a> [collection\_endpoint](#output\_collection\_endpoint) | n/a |
<!-- END_TF_DOCS -->
