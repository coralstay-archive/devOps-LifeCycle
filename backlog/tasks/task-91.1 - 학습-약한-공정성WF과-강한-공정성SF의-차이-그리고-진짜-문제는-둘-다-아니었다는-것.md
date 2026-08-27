---
id: TASK-91.1
title: '학습: 약한 공정성(WF)과 강한 공정성(SF)의 차이, 그리고 진짜 문제는 둘 다 아니었다는 것'
status: To Do
assignee: []
created_date: '2026-08-27 06:18'
labels: []
dependencies: []
documentation:
  - 'https://lamport.azurewebsites.net/video/videos.html'
parent_task_id: TASK-91
type: docs
ordinal: 181000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
이 스펙을 만들며 SF_vars로 바꿔도 한 번만 발생하고 사라지는 flapping은 못 잡는다는 걸 직접 확인했다(SF는 '무한히 자주' 활성화될 때만 강제한다). 결국 답은 공정성 강도를 올리는 게 아니라 속성의 전제(antecedent) 자체를 고치는 것이었다 — 실제 CloudWatch 알람도 평가 주기(EvaluationPeriods) 동안 breach가 지속돼야 Fire한다는 것과 왜 같은 이야기인지 CloudWatch 공식 문서의 알람 평가 로직에서 확인한다.
<!-- SECTION:DESCRIPTION:END -->
