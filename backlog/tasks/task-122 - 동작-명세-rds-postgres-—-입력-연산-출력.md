---
id: TASK-122
title: '동작 명세: rds-postgres — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:28'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/rds-postgres/spec.tla
documentation:
  - modules/rds-postgres/README.md
type: spike
ordinal: 273000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/rds-postgres/spec.tla — 이 모듈엔 master_password라는 변수가 아예 없다 — manage_master_user_password = true로 AWS가 비밀번호를 직접 생성해 Secrets Manager에 저장하게 위임한다. 그래서 이 모듈의 진짜 동작은 "비밀번호 자체는 절대 이 모듈의 출력에도, state에도 평문으로 나타나지 않고, 대신 그 비밀번호를 담은 Secrets Manager ARN만 나온다"는 것 — secrets-manager 모듈의 "출력에 비밀이 없다" 동작과 같은 종류의 속성이다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
