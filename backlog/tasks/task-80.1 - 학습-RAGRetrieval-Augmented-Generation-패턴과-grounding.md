---
id: TASK-80.1
title: '학습: RAG(Retrieval-Augmented Generation) 패턴과 grounding'
status: To Do
assignee: []
created_date: '2026-08-27 06:17'
labels: []
dependencies: []
documentation:
  - 'https://lamport.azurewebsites.net/tla/tla.html'
parent_task_id: TASK-80
type: docs
ordinal: 159000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Amazon Bedrock 공식 문서에서 Knowledge Bases(RAG 구현)가 검색 결과를 프롬프트에 어떻게 주입하는지 읽고, 이 스펙에 '검색 결과가 비어있으면(관련 문서 없음) 생성 자체를 막는다'는 조건을 Generate 액션에 추가해서 TLC로 검증해본다.
<!-- SECTION:DESCRIPTION:END -->
