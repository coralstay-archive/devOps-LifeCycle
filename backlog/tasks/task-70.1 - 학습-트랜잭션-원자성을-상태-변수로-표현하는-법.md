---
id: TASK-70.1
title: '학습: 트랜잭션 원자성을 상태 변수로 표현하는 법'
status: To Do
assignee: []
created_date: '2026-08-27 06:16'
labels: []
dependencies: []
documentation:
  - 'https://lamport.azurewebsites.net/tla/tla.html'
parent_task_id: TASK-70
type: docs
ordinal: 139000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
이 스펙은 '부분 커밋'이라는 상태 자체를 아예 만들지 않는 방식(committed := staged를 한 번에 대입)으로 원자성을 표현했다. Redshift COPY 명령 공식 문서에서 STATUPDATE/트랜잭션 동작을 찾아 읽고, 만약 여기에 '부분 실패 후 재시도'를 추가한다면 변수를 어떻게 바꿔야 할지 설계해본다.
<!-- SECTION:DESCRIPTION:END -->
