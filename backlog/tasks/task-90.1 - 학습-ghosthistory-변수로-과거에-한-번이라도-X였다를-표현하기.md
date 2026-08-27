---
id: TASK-90.1
title: '학습: ghost(history) 변수로 ''과거에 한 번이라도 X였다''를 표현하기'
status: To Do
assignee: []
created_date: '2026-08-27 06:18'
labels: []
dependencies: []
documentation:
  - 'https://lamport.azurewebsites.net/tla/book.html'
parent_task_id: TASK-90
type: docs
ordinal: 179000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
standard-web의 hadResurrection과 이 스펙의 promotedAfterFailure는 둘 다 '실제 시스템엔 없지만 검증을 위해 추가한' ghost 변수다. 왜 이런 변수를 실제 구현(예: Terraform)에 넣지 않고 스펙에만 넣는지, 그리고 이게 코드에 아무 부작용이 없다는 걸 각 스펙에서 UNCHANGED 절을 근거로 짚어본다.
<!-- SECTION:DESCRIPTION:END -->
