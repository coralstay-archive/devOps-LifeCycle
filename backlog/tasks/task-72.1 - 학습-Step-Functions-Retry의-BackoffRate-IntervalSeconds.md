---
id: TASK-72.1
title: '학습: Step Functions Retry의 BackoffRate/IntervalSeconds'
status: To Do
assignee: []
created_date: '2026-08-27 06:16'
labels: []
dependencies: []
documentation:
  - 'https://lamport.azurewebsites.net/tla/tla.html'
parent_task_id: TASK-72
type: docs
ordinal: 143000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
이 스펙은 재시도 '횟수'만 모델링하고 재시도 사이의 지수 백오프(exponential backoff) 시간은 다루지 않았다. AWS Step Functions 공식 문서의 Retry 필드(IntervalSeconds, BackoffRate, MaxAttempts)를 읽고, 왜 시간 개념을 TLA+에 넣으려면 완전히 다른 접근(예: 논리적 시계 변수)이 필요한지 생각해본다.
<!-- SECTION:DESCRIPTION:END -->
