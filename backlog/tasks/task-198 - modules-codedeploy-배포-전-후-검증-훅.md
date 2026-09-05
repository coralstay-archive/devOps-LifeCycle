---
id: TASK-198
title: 'modules/codedeploy: 배포 전/후 검증 훅'
status: To Do
assignee: []
created_date: '2026-09-05 04:08'
labels: []
milestone: m-23
dependencies: []
type: task
ordinal: 416000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
BeforeAllowTraffic/AfterAllowTraffic 훅(트래픽 전환 전/후 스모크테스트)이 modules/codedeploy에 전혀 없다. 이건 Terraform 리소스가 관리하는 영역이 아니라 배포 시점에 넘기는 appspec.yaml의 Hooks 섹션에서 연결된다는 점이 핵심 -- Terraform은 그 훅이 호출할 Lambda 함수와 CodeDeploy가 그걸 invoke할 IAM 권한까지만 관리한다. 이 구분을 README에 명확히 남기고, 실제 Lambda 예시(curl/health-check 후 PutLifecycleEventHookExecutionStatus로 결과 보고)와 appspec 템플릿 예시를 만든다. modules/codedeploy/README.md, scenarios/blue-green-deployment/README.md 갱신까지 포함.
<!-- SECTION:DESCRIPTION:END -->
