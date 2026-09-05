---
id: TASK-197
title: 'modules/codedeploy: CloudWatch 알람 자동 롤백'
status: To Do
assignee: []
created_date: '2026-09-05 04:08'
labels: []
milestone: m-23
dependencies: []
type: task
ordinal: 415000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
modules/codedeploy에는 auto_rollback_configuration이 전혀 없다(확인됨, 관련 블록 0건) -- 배포가 실패해도 자동으로 되돌아가는 안전장치가 없는 상태다. DEPLOYMENT_FAILURE/DEPLOYMENT_STOP_ON_ALARM 이벤트와 alarm_configuration(알람 이름 목록)을 변수/블록으로 추가한다. 알람 리소스 자체는 모듈에 넣지 않고 각 live/ 스택에서 raw aws_cloudwatch_metric_alarm으로 직접 선언한다 -- blue-green-deployment가 green target group을 모듈 밖에 선언해둔 선례를 따른다.
<!-- SECTION:DESCRIPTION:END -->
