---
id: TASK-5
title: '학습: `ec2` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:57'
labels:
  - module
  - ec2
milestone: m-0
dependencies: []
references:
  - modules/ec2
documentation:
  - 'https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html'
  - >-
    https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-instance-metadata-service.html
  - >-
    https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager.html
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
type: spike
ordinal: 9000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 원시 가상머신. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 IMDSv2가 막는 SSRF 공격 경로
- [ ] #2 SSH 키 대신 SSM Session Manager를 쓰는 이유
- [ ] #3 언제 EC2 대신 ECS/EKS를 써야 하는지
- [ ] #4 root_volume_size 최소값 precondition
<!-- AC:END -->
