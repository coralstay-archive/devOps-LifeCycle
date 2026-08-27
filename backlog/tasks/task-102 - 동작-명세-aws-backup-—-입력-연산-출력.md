---
id: TASK-102
title: '동작 명세: aws-backup — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:26'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/aws-backup/spec.tla
documentation:
  - modules/aws-backup/README.md
type: spike
ordinal: 233000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/aws-backup/spec.tla — 이 모듈의 핵심 동작은 백업 계획의 보존 기간(retention_days)이 실제로 vault/plan 설정에 그대로 반영되는지다 — 여기 값이 잘못 전달되면 "백업은 되고 있다고 생각했는데 필요할 때 보니 이미 삭제되어 있었다"는, 백업 시스템에서 가장 뒤늦게 발견되는 실패로 이어진다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
