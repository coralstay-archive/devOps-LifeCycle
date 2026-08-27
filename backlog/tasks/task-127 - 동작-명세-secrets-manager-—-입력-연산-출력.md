---
id: TASK-127
title: '동작 명세: secrets-manager — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:28'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/secrets-manager/spec.tla
documentation:
  - modules/secrets-manager/README.md
type: spike
ordinal: 283000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/secrets-manager/spec.tla — 이 모듈의 진짜 동작은 리소스 생성 순서가 아니라 보안 속성이다 — secret_string은 variables.tf에서 sensitive = true로 표시되는데, 그 값 자체가 절대 outputs.tf로 새어나가면 안 된다(출력은 오직 secret_arn/secret_id뿐, 실제 비밀 값은 출력에 없다). 이 "출력에 입력 비밀값이 나타나지 않는다"는 성질을 후행조건으로 명시적으로 검증 가능하게 만든다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
