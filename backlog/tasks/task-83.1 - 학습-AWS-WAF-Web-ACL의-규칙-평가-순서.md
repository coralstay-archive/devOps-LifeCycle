---
id: TASK-83.1
title: '학습: AWS WAF Web ACL의 규칙 평가 순서'
status: To Do
assignee: []
created_date: '2026-08-27 06:17'
labels: []
dependencies: []
documentation:
  - 'https://lamport.azurewebsites.net/tla/tla.html'
parent_task_id: TASK-83
type: docs
ordinal: 165000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
AWS WAF 공식 문서에서 Web ACL 규칙 평가 순서(우선순위, Allow/Block/Count 액션)를 읽고, 이 스펙에 rate-based rule(일정 시간 내 요청 수 초과 시 자동 차단)을 표현하려면 어떤 변수(예: requestCount, windowStart)가 필요할지 설계해본다.
<!-- SECTION:DESCRIPTION:END -->
