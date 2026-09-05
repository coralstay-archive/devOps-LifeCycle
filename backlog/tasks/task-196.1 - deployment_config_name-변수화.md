---
id: TASK-196.1
title: deployment_config_name 변수화
status: To Do
assignee: []
created_date: '2026-09-05 04:09'
labels: []
dependencies: []
parent_task_id: TASK-196
type: task
ordinal: 423000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
modules/codedeploy의 aws_codedeploy_deployment_group에 하드코딩된 deployment_config_name = CodeDeployDefault.ECSAllAtOnce를 변수로 뺀다. 기본값은 현행 유지(ECSAllAtOnce), 호출부에서 AWS 사전정의 config(ECSLinear10PercentEvery1Minutes, ECSCanary10Percent5Minutes 등)를 문자열로 지정할 수 있게 한다. 커스텀 비율/간격(aws_codedeploy_deployment_config 리소스)은 스코프 밖.
<!-- SECTION:DESCRIPTION:END -->
