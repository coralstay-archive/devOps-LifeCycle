---
id: TASK-80
title: 'TLA+ 명세: llm-rag-service — RAG 검색-생성 순서와 NoGenerationWithoutRetrieval'
status: Done
assignee: []
created_date: '2026-08-27 06:17'
updated_date: '2026-08-27 06:17'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/llm-rag-service/spec.tla
type: spike
ordinal: 158000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/llm-rag-service/spec.tla — Bedrock 답변 생성이 반드시 OpenSearch 검색 이후에만 일어난다는 RAG 패턴의 정의 그 자체를 명세했다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 TLC 검증: TypeInvariant, NoGenerationWithoutRetrieval 위반 없음
<!-- AC:END -->
