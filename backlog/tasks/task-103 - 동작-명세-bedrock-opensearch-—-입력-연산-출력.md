---
id: TASK-103
title: '동작 명세: bedrock-opensearch — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:26'
updated_date: '2026-08-27 14:32'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/bedrock-opensearch/spec.tla
documentation:
  - modules/bedrock-opensearch/README.md
type: spike
ordinal: 235000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/bedrock-opensearch/spec.tla — 이 모듈은 RAG(검색 증강 생성) 패턴의 "검색" 절반을 구성한다 — OpenSearch Serverless 컬렉션 하나와, Bedrock이 그 컬렉션을 읽고 쓸 수 있게 하는 IAM 역할 하나. 이 둘이 항상 함께 나와야 한다는 게 동작이다(역할 없이는 Bedrock이 벡터 검색을 절대 수행할 수 없다) — specs/llm-rag-service/spec.tla가 다루는 "검색 없이는 생성 없다"는 런타임 순서와 짝을 이루는, 배포 시점 동작이다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
