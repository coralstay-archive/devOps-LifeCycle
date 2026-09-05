---
id: TASK-194.1
title: live/spring-demo terraform destroy
status: To Do
assignee: []
created_date: '2026-09-05 03:25'
labels: []
dependencies: []
parent_task_id: TASK-194
type: task
ordinal: 411000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
live/spring-demo에서 terraform destroy를 사람이 직접 실행(승인 프롬프트에 yes). RDS의 skip_final_snapshot/deletion_protection 설정 때문에 destroy가 멈추거나 스냅샷이 남을 수 있으니 modules/rds-postgres 기본값을 destroy 실행 전에 확인해둔다.
<!-- SECTION:DESCRIPTION:END -->
