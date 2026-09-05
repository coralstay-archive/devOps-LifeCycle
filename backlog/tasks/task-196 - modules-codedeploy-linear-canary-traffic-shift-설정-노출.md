---
id: TASK-196
title: 'modules/codedeploy: linear/canary traffic-shift 설정 노출'
status: To Do
assignee: []
created_date: '2026-09-05 04:08'
labels: []
milestone: m-23
dependencies: []
type: task
ordinal: 414000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
modules/codedeploy는 README 자체가 'Implemented (minimal): all-at-once traffic shift'라고 명시할 만큼 deployment_config_name이 CodeDeployDefault.ECSAllAtOnce로 하드코딩돼 있다(main.tf 확인). AWS가 사전정의한 Linear/Canary config(예: ECSLinear10PercentEvery1Minutes, ECSCanary10Percent5Minutes)를 호출부에서 선택할 수 있게 변수화한다. 커스텀 비율/간격(aws_codedeploy_deployment_config 리소스)은 1차 스코프 밖 -- 사전정의 config만으로 충분하다고 판단.
<!-- SECTION:DESCRIPTION:END -->
