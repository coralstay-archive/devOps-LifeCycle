---
id: TASK-31
title: '학습: `organizations-landing-zone` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 05:00'
labels:
  - module
  - organizations-landing-zone
milestone: m-5
dependencies: []
references:
  - modules/organizations-landing-zone
documentation:
  - >-
    https://docs.aws.amazon.com/organizations/latest/userguide/orgs_introduction.html
  - >-
    https://docs.aws.amazon.com/controltower/latest/userguide/planning-your-deployment.html
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit
type: spike
ordinal: 61000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 멀티계정 구조. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 OU 설계
- [ ] #2 SCP
- [ ] #3 Control Tower와의 관계(이 모듈은 OU만 만듦)
- [ ] #4 for_each 리소스에 precondition을 달면 인스턴스 0개일 때 검증이 아예 안 도는 함정
- [ ] #5 대신 데이터소스에 다는 우회법
<!-- AC:END -->
