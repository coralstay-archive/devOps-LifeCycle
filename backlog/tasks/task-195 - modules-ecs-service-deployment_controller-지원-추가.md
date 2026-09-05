---
id: TASK-195
title: 'modules/ecs-service: deployment_controller 지원 추가'
status: To Do
assignee: []
created_date: '2026-09-05 04:07'
labels: []
milestone: m-23
dependencies: []
type: task
ordinal: 413000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
modules/ecs-service는 현재 deployment_controller를 전혀 노출하지 않는다(grep 결과 0건) -- 그래서 CodeDeploy가 옆에 있어도 ECS 서비스는 항상 자기 자신의 네이티브 rolling으로 트래픽을 관리한다. scenarios/blue-green-deployment가 이미 codedeploy 모듈까지 조합해뒀지만 이 갭 때문에 자기 README에 스스로 '알려진 제약'으로 적어둔 상태다. 이 스토리가 그 공유 블로커를 해소한다.
<!-- SECTION:DESCRIPTION:END -->
