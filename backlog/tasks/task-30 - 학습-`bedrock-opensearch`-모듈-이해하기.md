---
id: TASK-30
title: '학습: `bedrock-opensearch` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 05:00'
labels:
  - module
  - bedrock-opensearch
milestone: m-5
dependencies: []
references:
  - modules/bedrock-opensearch
documentation:
  - >-
    https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-create.html
  - >-
    https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless.html
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearchserverless_collection
type: spike
ordinal: 59000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: RAG 백엔드. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 RAG 흐름(임베딩→검색→생성)
- [ ] #2 벡터 유사도 검색
- [ ] #3 OpenSearch Serverless 보안정책
- [ ] #4 OpenSearch Serverless 컬렉션 네이밍 규칙 precondition
<!-- AC:END -->
