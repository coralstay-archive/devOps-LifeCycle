---
id: TASK-120
title: '동작 명세: observability — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:28'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/observability/spec.tla
documentation:
  - modules/observability/README.md
type: spike
ordinal: 269000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/observability/spec.tla — alarm_email이 null이면 SNS 토픽은 만들어지지만 구독자가 없다 — 알람이 울려도 아무도 못 받는 상태다. 이건 버그는 아니지만(Slack/PagerDuty를 나중에 따로 연결할 수 있으므로), "구독자 없는 알람 토픽"이라는 상태를 명시적으로 드러내는 게 이 스펙의 목적이다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
