---
id: TASK-98
title: '동작 명세: alb — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:25'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/alb/spec.tla
documentation:
  - modules/alb/README.md
type: spike
ordinal: 225000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/alb/spec.tla — 이 모듈의 진짜 동작은 certificate_arn의 유무에 따라 "외부에 노출되는 리스너"가 완전히 달라진다는 것이다 — 인증서가 없으면 HTTP 리스너가 직접 트래픽을 포워딩하고, 있으면 HTTP는 오직 HTTPS로 리다이렉트만 하고 실제 포워딩은 HTTPS 리스너가 한다. listener_arn 출력이 항상 "실제로 트래픽을 포워딩하는" 리스너를 가리켜야 한다는 게 이 모듈의 핵심 후행조건이다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
