---
id: TASK-199
title: scenarios/standard-web에 opt-in CodeDeploy 확장 (재사용 템플릿)
status: To Do
assignee: []
created_date: '2026-09-05 04:08'
labels: []
milestone: m-23
dependencies:
  - TASK-195
  - TASK-196
  - TASK-197
  - TASK-198
type: task
ordinal: 417000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Story A~D에서 확장한 모듈 기능들을 실제로 조합해서 쓸 수 있는 하나의 재사용 템플릿을 만든다. scenarios/standard-web에 enable_codedeploy(또는 deployment_strategy) 변수를 추가하되 기본값은 off/rolling으로 둬서 m-22의 live/spring-demo 동작에는 전혀 영향이 없게 한다. 켜지면 green target group + codedeploy 모듈 + ALB 5xx 알람(Story C의 live-레벨 선언 패턴)이 조건부로 구성된다. Story F/G/H가 이 템플릿을 복사해 deployment_config_name만 바꿔가며 쓴다.
<!-- SECTION:DESCRIPTION:END -->
