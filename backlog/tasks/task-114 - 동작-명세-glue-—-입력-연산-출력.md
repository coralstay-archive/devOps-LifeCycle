---
id: TASK-114
title: '동작 명세: glue — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:27'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/glue/spec.tla
documentation:
  - modules/glue/README.md
type: spike
ordinal: 257000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/glue/spec.tla — crawler_schedule이 null이면 수동 실행(on-demand)만 가능하고, 값이 있으면 그 cron으로 자동 실행된다 — 이 분기가 정확히 반영되는지가 핵심.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
