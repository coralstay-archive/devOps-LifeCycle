---
id: TASK-97
title: '동작 명세: acm — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:25'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/acm/spec.tla
documentation:
  - modules/acm/README.md
type: spike
ordinal: 223000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/acm/spec.tla — DNS 검증 방식 인증서 발급의 핵심 동작: 최종 반환되는 certificate_arn은 반드시 domain_name과 모든 subject_alternative_names를 커버하는 "검증 완료된" 인증서를 가리켜야 한다 — 검증이 끝나기 전의 PENDING_VALIDATION 상태 인증서를 그냥 돌려주면 안 된다는 게 aws_acm_certificate_validation 리소스가 존재하는 이유다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
