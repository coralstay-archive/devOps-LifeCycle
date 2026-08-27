---
id: TASK-68.1
title: '학습: Kafka 파티션의 순서 보장과 컨슈머 오프셋'
status: To Do
assignee: []
created_date: '2026-08-27 06:15'
labels: []
dependencies: []
documentation:
  - 'https://lamport.azurewebsites.net/tla/tla.html'
parent_task_id: TASK-68
type: docs
ordinal: 135000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
이 스펙은 파티션 내 순서 보장을 매우 단순화한 카운터 모델로 표현했다. 실제 Kafka는 파티션이 여러 개면 파티션 간에는 순서를 보장하지 않는다 — msk-kafka 모듈 README를 다시 읽고, 왜 파티션 키(partition key) 선택이 순서 보장 범위를 결정하는지 정리해본 뒤, 이 스펙을 파티션 2개로 확장하면 어떤 변수가 더 필요할지 직접 스케치해본다.
<!-- SECTION:DESCRIPTION:END -->
