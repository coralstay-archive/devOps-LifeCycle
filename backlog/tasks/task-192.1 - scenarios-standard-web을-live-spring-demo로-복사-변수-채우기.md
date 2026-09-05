---
id: TASK-192.1
title: scenarios/standard-web을 live/spring-demo로 복사 + 변수 채우기
status: To Do
assignee: []
created_date: '2026-09-05 03:25'
labels: []
dependencies: []
parent_task_id: TASK-192
type: task
ordinal: 407000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
cp -r scenarios/standard-web live/spring-demo 후, backend.tf에 TASK-178이 만든 실제 state 버킷 이름을 채우고, providers.tf의 region을 확인하고, terraform.tfvars(또는 -var)로 name 등 변수를 채운다. container_image는 일단 기본값(placeholder nginx)로 둔 채 terraform validate까지만 먼저 확인해도 된다.
<!-- SECTION:DESCRIPTION:END -->
