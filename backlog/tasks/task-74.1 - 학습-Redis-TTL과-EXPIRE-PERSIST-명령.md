---
id: TASK-74.1
title: '학습: Redis TTL과 EXPIRE/PERSIST 명령'
status: To Do
assignee: []
created_date: '2026-08-27 06:16'
labels: []
dependencies: []
documentation:
  - 'https://lamport.azurewebsites.net/tla/tla.html'
parent_task_id: TASK-74
type: docs
ordinal: 147000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Redis 공식 문서에서 EXPIRE, TTL, PERSIST 명령을 읽고, 만약 세션 갱신(sliding expiration — 활동 시 TTL 리셋)을 추가한다면 이 스펙에 어떤 액션(예: RefreshSession)을 추가해야 할지 설계해서 실제로 spec.tla에 추가하고 TLC로 검증해본다.
<!-- SECTION:DESCRIPTION:END -->
