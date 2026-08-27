---
id: TASK-3
title: '학습: `iam-github-oidc` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:57'
labels:
  - module
  - iam-github-oidc
milestone: m-0
dependencies: []
references:
  - modules/iam-github-oidc
documentation:
  - >-
    https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc.html
  - >-
    https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider
type: spike
ordinal: 5000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: CI 자격증명 연합. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 OIDC 연합 원리
- [ ] #2 `sts:AssumeRoleWithWebIdentity`
- [ ] #3 신뢰정책의 `sub`/`aud` 조건
- [ ] #4 plan/apply 역할 분리 이유
- [ ] #5 allowed_ref 형식을 precondition으로 강제하기
<!-- AC:END -->
