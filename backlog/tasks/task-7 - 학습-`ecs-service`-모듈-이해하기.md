---
id: TASK-7
title: '학습: `ecs-service` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:57'
labels:
  - module
  - ecs-service
milestone: m-1
dependencies: []
references:
  - modules/ecs-service
documentation:
  - 'https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html'
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition
type: spike
ordinal: 13000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 컨테이너 오케스트레이션(AWS 네이티브). 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Fargate vs EC2 launch type
- [ ] #2 태스크 실행역할 vs 태스크역할 차이
- [ ] #3 서비스 오토스케일링
- [ ] #4 `deployment_controller`
- [ ] #5 private_subnet_ids 비어있지 않은지 precondition
<!-- AC:END -->
