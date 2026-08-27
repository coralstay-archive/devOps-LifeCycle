---
id: TASK-34
title: '학습: `codedeploy` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 05:00'
labels:
  - module
  - codedeploy
milestone: m-5
dependencies: []
references:
  - modules/codedeploy
documentation:
  - 'https://docs.aws.amazon.com/codedeploy/latest/userguide/welcome.html'
  - >-
    https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deploy-blue-green-service.html
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_deployment_group
type: spike
ordinal: 67000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 배포 오케스트레이션. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 블루/그린 vs 롤링
- [ ] #2 ECS `deployment_controller` 연동 필요성
- [ ] #3 배포 훅
- [ ] #4 blue/green 타겟그룹 이름이 달라야 한다는 precondition (복붙 실수 방지)
<!-- AC:END -->
