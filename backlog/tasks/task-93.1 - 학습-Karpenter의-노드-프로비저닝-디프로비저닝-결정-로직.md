---
id: TASK-93.1
title: '학습: Karpenter의 노드 프로비저닝/디프로비저닝 결정 로직'
status: To Do
assignee: []
created_date: '2026-08-27 06:19'
labels: []
dependencies: []
documentation:
  - 'https://lamport.azurewebsites.net/tla/tla.html'
parent_task_id: TASK-93
type: docs
ordinal: 186000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Karpenter 공식 문서에서 NodePool의 disruption 설정과 컨솔리데이션(consolidation) 정책을 읽고, 이 스펙의 ScaleDown이 '즉시'가 아니라 실제로는 유예 시간(consolidateAfter)을 두고 일어난다는 점을 반영하려면 어떤 변수가 필요할지 생각해본다.
<!-- SECTION:DESCRIPTION:END -->
