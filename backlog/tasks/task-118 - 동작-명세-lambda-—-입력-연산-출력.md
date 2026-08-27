---
id: TASK-118
title: '동작 명세: lambda — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:27'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/lambda/spec.tla
documentation:
  - modules/lambda/README.md
type: spike
ordinal: 265000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/lambda/spec.tla — 이 모듈이 실행 역할(IAM Role)을 항상 자체적으로 만든다는 것, 그리고 invoke_arn이 function_arn으로부터 파생된 값(API Gateway 등이 실제로 호출할 때 쓰는 형태)이라는 관계가 핵심 동작이다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
