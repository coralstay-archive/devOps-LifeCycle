---
id: TASK-200.3
title: live/spring-demo-bluegreen destroy + AWS CLI 이중 확인
status: To Do
assignee: []
created_date: '2026-09-05 04:11'
labels: []
dependencies: []
parent_task_id: TASK-200
type: task
ordinal: 434000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
terraform destroy 실행 후 aws ecs/rds/elbv2/ec2 describe-* 로 실제 삭제를 이중 확인한다 (m-22 TASK-194.2와 같은 패턴).
<!-- SECTION:DESCRIPTION:END -->
