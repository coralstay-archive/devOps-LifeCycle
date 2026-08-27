---
id: TASK-73.1
title: '학습: cache-aside vs write-through 캐싱 전략'
status: To Do
assignee: []
created_date: '2026-08-27 06:16'
labels: []
dependencies: []
documentation:
  - 'https://lamport.azurewebsites.net/tla/tla.html'
parent_task_id: TASK-73
type: docs
ordinal: 145000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
이 스펙은 cache-aside(쓰기 시 무효화만) 전략을 모델링했다. ElastiCache/Redis 공식 문서에서 write-through 전략과의 차이를 읽고, write-through로 바꾸면 WriteAndInvalidate 액션이 어떻게 바뀌어야 하는지(캐시를 지우는 대신 즉시 갱신) 직접 고쳐서 TLC로 재검증해본다.
<!-- SECTION:DESCRIPTION:END -->
