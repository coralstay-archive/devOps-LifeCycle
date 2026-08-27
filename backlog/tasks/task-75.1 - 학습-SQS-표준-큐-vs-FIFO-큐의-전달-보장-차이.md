---
id: TASK-75.1
title: '학습: SQS 표준 큐 vs FIFO 큐의 전달 보장 차이'
status: To Do
assignee: []
created_date: '2026-08-27 06:16'
labels: []
dependencies: []
documentation:
  - 'https://lamport.azurewebsites.net/tla/tla.html'
parent_task_id: TASK-75
type: docs
ordinal: 149000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Amazon SQS 공식 문서에서 표준 큐(at-least-once, 순서 미보장)와 FIFO 큐(exactly-once processing, 순서 보장)의 차이를 읽고, 이 스펙을 FIFO 큐 가정으로 바꾸면 alreadyProcessed 같은 멱등성 로직이 여전히 필요한지, 왜 그런지 정리한다.
<!-- SECTION:DESCRIPTION:END -->
