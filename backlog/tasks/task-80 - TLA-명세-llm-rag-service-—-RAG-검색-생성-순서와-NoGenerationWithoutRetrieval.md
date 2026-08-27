---
id: TASK-80
title: 'TLA+ 명세: llm-rag-service — RAG 검색-생성 순서와 NoGenerationWithoutRetrieval'
status: To Do
assignee: []
created_date: '2026-08-27 06:17'
updated_date: '2026-08-27 06:43'
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
specs/llm-rag-service/spec.tla — Bedrock 답변 생성이 반드시 OpenSearch 검색 이후에만 일어난다는 RAG 패턴의 정의 그 자체를 명세하고 TLC로 검증한다.

공식문서를 찾아보며 왜 이런 제약이 실제 AWS 서비스의 동작에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 스펙이 모델링하는 시스템 동작(무엇이 상태 변수고 무엇이 액션인지)을 자신의 말로 설명할 수 있다
- [ ] #2 TypeInvariant, NoGenerationWithoutRetrieval이(가) 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
