---
id: TASK-115
title: '동작 명세: iam — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:27'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/iam/spec.tla
documentation:
  - modules/iam/README.md
type: spike
ordinal: 259000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/iam/spec.tla — 이 모듈(범용 IAM 역할)의 진짜 동작은 "누가 이 역할을 맡을 수 있는가"(assume_role_services)와 "이 역할이 뭘 할 수 있는가"(managed_policy_arns + inline_policy_json)가 입력에서 정확히 그대로 출력(신뢰 정책, 연결된 정책 목록)에 반영되는지다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
