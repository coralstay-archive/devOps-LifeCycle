---
id: TASK-117
title: '동작 명세: kms — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:27'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/kms/spec.tla
documentation:
  - modules/kms/README.md
type: spike
ordinal: 263000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/kms/spec.tla — 이 모듈은 이미 main.tf의 lifecycle.precondition으로 "deletion_window_in_days는 7~30일 사이"라는 KMS API 자체의 제약을 강제하고 있다(decision-2가 다루는 모듈 스코프 precondition/postcondition) — 여기서는 그 동일한 제약을 사전조건(precondition)으로 다시 표현해, "입력 도메인 제약"과 "알고리즘이 그 도메인 안에서 실제로 무엇을 보장하는가(후행조건)"를 분리해서 보여주는 용도로 쓴다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
