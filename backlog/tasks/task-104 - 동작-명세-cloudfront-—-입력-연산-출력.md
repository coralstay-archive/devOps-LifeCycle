---
id: TASK-104
title: '동작 명세: cloudfront — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:26'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/cloudfront/spec.tla
documentation:
  - modules/cloudfront/README.md
type: spike
ordinal: 237000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/cloudfront/spec.tla — main.tf가 이미 강제하는 "certificate_arn을 줬으면 aliases가 최소 1개"라는 제약(커스텀 인증서인데 그걸 서빙할 커스텀 도메인이 없는 건 모순)을 사전조건으로 재확인하고, 그 조합에 따라 cloudfront_default_certificate 플래그가 정확히 반대로 켜지는지 후행조건으로 검증한다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
