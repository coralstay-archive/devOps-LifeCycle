---
id: TASK-198.2
title: appspec Hooks 연결 방식 문서화 + 템플릿 추가
status: To Do
assignee: []
created_date: '2026-09-05 04:10'
labels: []
dependencies: []
parent_task_id: TASK-198
type: task
ordinal: 428000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
이 훅은 Terraform이 관리하는 aws_codedeploy_deployment_group의 블록이 아니라, 배포 시점에 넘기는 appspec.yaml의 Hooks 섹션에서 연결된다는 걸 명확히 문서화한다. Terraform은 Lambda 함수 자체와 CodeDeploy가 그 Lambda를 invoke할 IAM 권한까지만 관리한다는 구분을 남기고, live/ 쪽에 appspec 템플릿 예시 파일을 추가한다.
<!-- SECTION:DESCRIPTION:END -->
