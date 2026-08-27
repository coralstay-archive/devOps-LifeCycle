---
id: TASK-132
title: '동작 명세: waf-shield — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:29'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/waf-shield/spec.tla
documentation:
  - modules/waf-shield/README.md
type: spike
ordinal: 293000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/waf-shield/spec.tla — scope는 WAFv2가 실제로 허용하는 두 값(REGIONAL/CLOUDFRONT) 중 하나여야 한다는 사전조건, 그리고 두 개의 선택적 리소스(Web ACL 연결, Shield Advanced 보호)가 각각 정확히 어떤 조건에서만 생기는지가 핵심 동작 — resource_arn이 없으면 scope와 무관하게 둘 다 안 생겨야 하고, CLOUDFRONT scope에서는 별도 연결 리소스 자체가 존재하면 안 된다 (CloudFront는 자기 자신의 web_acl_id 인자로 붙기 때문).

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
