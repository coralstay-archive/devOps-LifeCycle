---
id: TASK-197.2
title: 알람 리소스 선언 위치 결정 + live 템플릿에 반영
status: To Do
assignee: []
created_date: '2026-09-05 04:10'
labels: []
dependencies: []
parent_task_id: TASK-197
type: task
ordinal: 426000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
CloudWatch 알람(예: ALB 5xx 비율) 리소스는 modules/codedeploy나 modules/observability에 넣지 않고, blue-green-deployment가 green target group을 모듈 밖에 직접 선언한 선례를 따라 각 live/ 스택에서 raw aws_cloudwatch_metric_alarm으로 직접 선언한다. TASK-199(Story E 템플릿)에 이 패턴을 포함시킨다.
<!-- SECTION:DESCRIPTION:END -->
