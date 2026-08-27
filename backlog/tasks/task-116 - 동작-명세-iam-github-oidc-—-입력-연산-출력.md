---
id: TASK-116
title: '동작 명세: iam-github-oidc — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:27'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/iam-github-oidc/spec.tla
documentation:
  - >-
    https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect
type: spike
ordinal: 261000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/iam-github-oidc/spec.tla — 이 모듈에서 진짜 중요한 건 리소스 생성 순서가 아니라 — 신뢰 정책(trust policy)의 sub 조건 문자열이 정확히 "repo:{org}/{repo}:ref:{allowed_ref}" 형태로 만들어지는가다. 이게 틀리면 전혀 다른 저장소나 브랜치가 이 역할을 가로챌 수 있다 — main.tf의 lifecycle.precondition이 "allowed_ref가 refs/로 시작해야 한다"는 흔한 실수(브랜치 이름만 넣는 것)를 막는 것과 정확히 같은 문제의식이다. 여기서는 그 문자열 자체가 항상 올바른 형태로 조립되는지를 후행조건으로 못박는다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
