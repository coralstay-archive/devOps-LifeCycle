---
id: TASK-193.2
title: ALB 엔드포인트로 curl 실사용 검증
status: To Do
assignee: []
created_date: '2026-09-05 03:25'
labels: []
dependencies: []
parent_task_id: TASK-193
type: task
ordinal: 410000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
apply로 나온 alb_dns_name에 curl로 /health와 DB 연동 엔드포인트를 호출해, 로컬 docker-compose(TASK-191.3)에서 확인했던 것과 동일한 동작이 실제 AWS(ECS Fargate + RDS)에서도 나오는지 확인한다. 이게 이 milestone 전체의 검증 목표다.
<!-- SECTION:DESCRIPTION:END -->
