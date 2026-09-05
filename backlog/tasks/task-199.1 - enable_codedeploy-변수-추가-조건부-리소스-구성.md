---
id: TASK-199.1
title: enable_codedeploy 변수 추가 + 조건부 리소스 구성
status: To Do
assignee: []
created_date: '2026-09-05 04:10'
labels: []
dependencies: []
parent_task_id: TASK-199
type: task
ordinal: 430000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
scenarios/standard-web에 enable_codedeploy(또는 deployment_strategy) 변수를 추가한다. 기본값 off/rolling -- m-22의 live/spring-demo 동작에는 전혀 영향 없음. 켜지면 green target group + codedeploy 모듈(TASK-196/197 산출물) + ALB 5xx 알람(TASK-197.2 패턴)이 조건부로 구성된다.
<!-- SECTION:DESCRIPTION:END -->
