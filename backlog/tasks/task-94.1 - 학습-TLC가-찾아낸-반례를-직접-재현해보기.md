---
id: TASK-94.1
title: '학습: TLC가 찾아낸 반례를 직접 재현해보기'
status: To Do
assignee: []
created_date: '2026-08-27 06:19'
labels: []
dependencies: []
documentation:
  - 'https://lamport.azurewebsites.net/tla/tla.html'
parent_task_id: TASK-94
type: docs
ordinal: 188000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
git 이력(또는 이 태스크 설명)에 남은 '수정 전' DispatchCold 정의(warmInstances < MaxConcurrency 가드 없이)로 spec.tla를 잠깐 되돌려 TLC를 다시 돌려보고, 실제로 어떤 상태 시퀀스에서 TypeInvariant가 깨지는지 반례(counter-example) 트레이스를 직접 읽어본다. 이게 TLA+가 'TDD의 상태 공간 버전'이라고 불리는 이유다.
<!-- SECTION:DESCRIPTION:END -->
