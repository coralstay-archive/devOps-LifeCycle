---
id: TASK-192.2
title: 빌드한 이미지를 ECR에 푸시하고 container_image 교체
status: To Do
assignee: []
created_date: '2026-09-05 03:25'
labels: []
dependencies: []
parent_task_id: TASK-192
type: task
ordinal: 408000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
TASK-191.1에서 만든 Dockerfile로 이미지를 빌드하고, aws ecr get-login-password | docker login으로 인증한 뒤 live/spring-demo의 ecr 모듈이 만드는 리포지토리 URL로 push한다. 이후 terraform.tfvars의 container_image를 그 실제 ECR URL:tag로 교체한다.
<!-- SECTION:DESCRIPTION:END -->
