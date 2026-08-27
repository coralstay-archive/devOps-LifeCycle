---
id: TASK-129
title: '동작 명세: step-functions — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:29'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/step-functions/spec.tla
documentation:
  - modules/step-functions/README.md
type: spike
ordinal: 287000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/step-functions/spec.tla — 이 모듈의 동작은 단순하다 — policy_arns로 넘긴 권한 개수만큼 실행 역할에 정책이 붙어야 하고, role_arn과 state_machine_arn은 항상 함께 나와야 한다(상태 머신은 역할 없이 아무 것도 실행할 수 없다).

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
