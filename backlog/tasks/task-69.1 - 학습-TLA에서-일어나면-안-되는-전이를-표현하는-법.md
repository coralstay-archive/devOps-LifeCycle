---
id: TASK-69.1
title: '학습: TLA+에서 ''일어나면 안 되는 전이''를 표현하는 법'
status: To Do
assignee: []
created_date: '2026-08-27 06:15'
labels: []
dependencies: []
documentation:
  - 'https://lamport.azurewebsites.net/tla/tla.html'
parent_task_id: TASK-69
type: docs
ordinal: 137000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
이 스펙의 QueryBeforeCatalog 액션은 일부러 주석 처리되어 Next에 포함되지 않았다. 왜 '금지된 전이를 아예 안 쓰는 것'과 '금지된 전이를 쓰고 불변식으로 막는 것'이 다른 검증 강도를 갖는지 생각해보고, 이 스펙의 Invalidate 액션을 하나 추가해 실제로 불변식이 깨지는 걸 TLC로 직접 재현해본다.
<!-- SECTION:DESCRIPTION:END -->
