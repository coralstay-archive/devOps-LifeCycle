# llm-rag-service

**카테고리**: ML/AI
**설명**: Bedrock+OpenSearch로 RAG 기반 LLM 서비스 구성.

## 상태

composed — `bedrock-opensearch` 모듈을 그대로 노출. `aws_bedrockagent_knowledge_base` 리소스 자체는 `bedrock-opensearch` 모듈 README에 적힌 대로 후속 작업.

## 관련 모듈

bedrock-opensearch

## 참고자료

- 관련 모듈 문서: `bedrock-opensearch`

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_name"></a> [name](#input\_name) | Base name used as the prefix/tag for the Bedrock/OpenSearch RAG resources. | `string` | `"llm-rag-service"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_collection_endpoint"></a> [collection\_endpoint](#output\_collection\_endpoint) | OpenSearch Serverless collection endpoint holding the RAG vector index. |
<!-- END_TF_DOCS -->