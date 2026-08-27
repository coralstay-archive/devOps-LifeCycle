---
id: TASK-81.1
title: '학습: AWS Control Tower의 Account Factory와 가드레일'
status: To Do
assignee: []
created_date: '2026-08-27 06:17'
labels: []
dependencies: []
documentation:
  - 'https://lamport.azurewebsites.net/tla/tla.html'
parent_task_id: TASK-81
type: docs
ordinal: 161000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
AWS Control Tower 공식 문서에서 Account Factory가 새 계정을 OU에 배치하고 필수 가드레일(mandatory guardrails)을 적용하는 순서를 읽고, 이 스펙을 '계정 생성'과 'SCP 적용'을 별도의 두 액션으로 쪼개면 어떤 중간 상태(가드레일 없는 활성 계정)가 생기는지, 왜 실제로는 원자적으로 처리되어야 하는지 설명해본다.
<!-- SECTION:DESCRIPTION:END -->
