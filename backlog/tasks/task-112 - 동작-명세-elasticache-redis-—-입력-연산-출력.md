---
id: TASK-112
title: '동작 명세: elasticache-redis — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:27'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/elasticache-redis/spec.tla
documentation:
  - modules/elasticache-redis/README.md
type: spike
ordinal: 253000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/elasticache-redis/spec.tla — num_cache_nodes가 1이면 자동 페일오버는 켤 수 없다(승격할 복제본이 없으므로) — main.tf의 automatic_failover_enabled = var.num_cache_nodes > 1이 바로 그 논리다. 이 분기를 후행조건으로 명시한다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
