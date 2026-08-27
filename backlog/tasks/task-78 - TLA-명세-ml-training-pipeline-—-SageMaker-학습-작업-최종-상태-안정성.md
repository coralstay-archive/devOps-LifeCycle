---
id: TASK-78
title: 'TLA+ 명세: ml-training-pipeline — SageMaker 학습 작업 최종 상태 안정성 (공허한 속성 버그를 발견함)'
status: To Do
assignee: []
created_date: '2026-08-27 06:16'
updated_date: '2026-08-27 09:13'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/ml-training-pipeline/spec.tla
type: spike
ordinal: 154000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/ml-training-pipeline/spec.tla — Completed/Failed가 최종 상태로서 한 번 도달하면 영원히 유지된다는 것을 PROPERTY(FinalStatesAreStable)로 먼저 `(state = "Completed") => [](state = "Completed")`처럼(바깥쪽 [] 없이) 명세해본다. Init에서 state가 항상 "InProgress"로 시작하는 한 이 조건은 t=0에서 이미 거짓이라 전체 behavior에서 공허하게 항상 참이 되어버린다 — Completed에서 다시 InProgress로 돌아가는 명백한 버그를 Next에 넣어도 TLC가 "No error"라고 답하는 걸로 직접 확인한다. 올바른 관용구인 `[](state = "Completed" => [](state = "Completed"))`(바깥에 [] 한 번 더)로 고쳐 재검증한다.

공식문서를 찾아보며 왜 이런 제약이 실제 AWS 서비스의 동작에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 스펙이 모델링하는 시스템 동작(무엇이 상태 변수고 무엇이 액션인지)을 자신의 말로 설명할 수 있다
- [ ] #2 TypeInvariant, FinalStatesAreStable이(가) 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
- [ ] #3 이 스펙을 만드는 과정에서 발견된 공허한(vacuous) 속성 버그가 무엇이었고 왜 그렇게 되는지 설명할 수 있다
<!-- AC:END -->
