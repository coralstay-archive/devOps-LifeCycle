---
id: TASK-100
title: '동작 명세: api-gateway — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:25'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/api-gateway/spec.tla
documentation:
  - modules/api-gateway/README.md
type: spike
ordinal: 229000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/api-gateway/spec.tla — 이 모듈은 lambda 모듈의 invoke_arn을 입력으로 받아 그대로 라우트에 연결하는 "접착제" 역할이라, 동작도 단순하다: route_key로 지정한 라우트가 정확히 그 lambda_invoke_arn을 가리켜야 한다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
