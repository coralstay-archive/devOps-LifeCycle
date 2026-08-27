---
id: TASK-77.1
title: '학습: EventBridge Scheduler의 FlexibleTimeWindow'
status: To Do
assignee: []
created_date: '2026-08-27 06:16'
labels: []
dependencies: []
documentation:
  - 'https://lamport.azurewebsites.net/tla/tla.html'
parent_task_id: TASK-77
type: docs
ordinal: 153000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Amazon EventBridge Scheduler 공식 문서에서 FlexibleTimeWindow와 재시도 정책을 읽고, 이 스펙에 '건너뛴 트리거 횟수(skippedCount)'를 세는 변수를 추가해서 무한정 스킵되는 상황이 없는지(예: 항상 언젠가는 실행된다는 활성 속성) 검증할 수 있을지 생각해본다.
<!-- SECTION:DESCRIPTION:END -->
