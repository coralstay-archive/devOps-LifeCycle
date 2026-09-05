---
id: TASK-195.1
title: deployment_controller 변수/블록 추가
status: To Do
assignee: []
created_date: '2026-09-05 04:09'
labels: []
dependencies: []
parent_task_id: TASK-195
type: task
ordinal: 421000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
aws_ecs_service 리소스에 deployment_controller 블록 추가. 기본값 ROLLING(현행 동작 그대로 유지), 옵션 CODE_DEPLOY. CODE_DEPLOY일 때는 CodeDeploy가 태스크셋/트래픽을 관리하게 되므로 task_definition, desired_count처럼 CodeDeploy가 배포마다 바꾸는 필드에 lifecycle.ignore_changes가 필요한지 검토하고 README에 그 이유를 남긴다.
<!-- SECTION:DESCRIPTION:END -->
