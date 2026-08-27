---
id: TASK-76.1
title: '학습: 약한 공정성(WF)이 없으면 활성 속성이 왜 깨지는가'
status: To Do
assignee: []
created_date: '2026-08-27 06:16'
labels: []
dependencies: []
documentation:
  - 'https://lamport.azurewebsites.net/video/videos.html'
parent_task_id: TASK-76
type: docs
ordinal: 151000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
spec.cfg에서 SPECIFICATION Spec 대신 Init /\ [][Next]_vars 만 쓰도록(공정성 없이) 임시로 바꿔서 PROPERTY EventuallyAllReceive를 다시 검증해보고, TLC가 어떤 반례(무한 stuttering)를 찾아내는지 직접 확인한다. 공식 TLA+ 비디오 코스의 '공정성(Fairness)' 강의를 참고.
<!-- SECTION:DESCRIPTION:END -->
