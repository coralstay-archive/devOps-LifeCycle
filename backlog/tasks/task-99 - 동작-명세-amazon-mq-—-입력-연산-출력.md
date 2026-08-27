---
id: TASK-99
title: '동작 명세: amazon-mq — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:25'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/amazon-mq/spec.tla
documentation:
  - modules/amazon-mq/README.md
type: spike
ordinal: 227000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/amazon-mq/spec.tla — password는 variables.tf에서 sensitive = true지만, 이 모듈은 rds-postgres/redshift와 달리 AWS 관리형 비밀번호 기능이 없다 — 그래서 이 값이 새어나갈 수 있는 유일한 경로는 이 모듈의 출력이다. outputs.tf에는 broker_id와 endpoints뿐이라는 걸 후행조건으로 못박아, "출력에 비밀번호 필드가 없다"는 게 우연이 아니라 강제된 성질임을 드러낸다 — secrets-manager 모듈의 같은 종류의 동작과 짝을 이룬다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
