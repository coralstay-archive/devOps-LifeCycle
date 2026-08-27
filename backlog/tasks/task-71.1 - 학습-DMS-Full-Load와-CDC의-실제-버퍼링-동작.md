---
id: TASK-71.1
title: '학습: DMS Full Load와 CDC의 실제 버퍼링 동작'
status: To Do
assignee: []
created_date: '2026-08-27 06:16'
labels: []
dependencies: []
documentation:
  - 'https://lamport.azurewebsites.net/tla/tla.html'
parent_task_id: TASK-71
type: docs
ordinal: 141000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
AWS DMS 공식 문서에서 'Full Load and CDC 태스크'가 Full Load 중 발생한 변경분을 어떻게 캐시/버퍼링하는지 찾아 읽고, 이 스펙의 phase 변수를 3단계(FullLoad, CDCApplyingBuffered, CDCLive)로 세분화하면 어떤 새 불변식이 필요할지 정리한다.
<!-- SECTION:DESCRIPTION:END -->
