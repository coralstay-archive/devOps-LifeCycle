---
id: TASK-201
title: 'live/spring-demo-linear: Linear 실전 배포 + 롤백 검증 + 파괴'
status: To Do
assignee: []
created_date: '2026-09-05 04:09'
labels: []
milestone: m-23
dependencies:
  - TASK-200
type: task
ordinal: 419000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
TASK-199 템플릿을 live/spring-demo-linear로 복사해 deployment_config_name을 Linear 계열(예: ECSLinear10PercentEvery1Minutes)로 설정해 apply한다. 전환 구간 동안 주기적으로 curl해 old/new 버전 응답이 섞이는 구간을 직접 관찰/기록한다. 의도적 실패 이미지로 재배포해 auto-rollback을 확인하고, destroy 후 AWS CLI로 이중 확인한다. TASK-200(All-at-once) 완료 후 진행 -- 배포 전략 이해도가 쌓이는 순서(all-at-once가 가장 단순 -> linear -> canary가 가장 정교)로 하나씩 검증한다.
<!-- SECTION:DESCRIPTION:END -->
