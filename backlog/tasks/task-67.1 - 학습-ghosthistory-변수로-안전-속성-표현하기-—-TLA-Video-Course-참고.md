---
id: TASK-67.1
title: '학습: ghost(history) 변수로 안전 속성 표현하기 — TLA+ Video Course 참고'
status: To Do
assignee: []
created_date: '2026-08-27 06:19'
labels: []
dependencies: []
documentation:
  - 'https://lamport.azurewebsites.net/video/videos.html'
parent_task_id: TASK-67
type: docs
ordinal: 184000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
hadResurrection 변수는 실제 ALB에는 없는, 검증만을 위한 ghost(history) 변수다. Lamport의 TLA+ Video Course에서 '역사 변수(history variables)'를 다루는 강의를 보고, 왜 ghost 변수를 추가해도 Spec이 표현하는 실제 시스템 동작에는 아무 영향이 없는지(UNCHANGED 관점에서) 설명해본다. canary-deployment의 promotedAfterFailure와 비교해서 정리하면 더 좋다.
<!-- SECTION:DESCRIPTION:END -->
