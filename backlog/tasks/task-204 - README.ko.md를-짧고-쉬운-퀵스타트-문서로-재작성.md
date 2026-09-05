---
id: TASK-204
title: README.ko.md를 짧고 쉬운 퀵스타트 문서로 재작성
status: Done
assignee: []
created_date: '2026-09-05 08:45'
updated_date: '2026-09-05 08:46'
labels: []
dependencies: []
ordinal: 442000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
README.ko.md가 README.md의 상세한 1:1 번역본(약 300줄)이었는데, 이걸 그대로 유지하지 않고 짧고 쉬운 요약본으로 재작성한다 -- 이 프로젝트가 뭘 하는지 처음 보는 사람도 한눈에 알 수 있게, 그리고 지금 당장 뭘 해야 하는지(m-22 간단 배포부터, 나머지 36개 모듈/30개 시나리오/66개 TLA+ 명세는 전부 나중에 필요할 때 찾아보는 학습 자료)를 단계별로 명시한다. 저장소 전체(모듈 36개, 시나리오 30개 전체 README, live/example-dev, CI 워크플로, backlog/decisions 5개, policy/specs/bootstrap/tools README)를 다시 훑어서 정확한 현재 상태(실제로 AWS에 배포된 적 한 번도 없음, 시나리오 중 완전 동작 ~20개/문서화된 제약 ~7개/이름만 있는 스텁 3개 등)를 반영한다. README.md(영어)는 그대로 두고 손대지 않는다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 README.ko.md가 훨씬 짧아지고(대략 300줄 -> 100줄 이내), 쉬운 말로 쓰여 있다
- [x] #2 이 프로젝트가 무엇을 하는지(modules->scenarios->live->AWS 흐름) 단계별로 명확히 설명한다
- [x] #3 가장 먼저 할 일(m-22 간단 배포)과 나머지 학습 자료(모듈/시나리오/TLA+ 명세)가 명확히 구분되어 있다
- [x] #4 현재 상태(AWS 미배포, 시나리오 완성도 구분)가 정직하게 반영되어 있다
- [x] #5 README.md는 변경되지 않는다
<!-- AC:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
저장소 전체(모듈 36개, 시나리오 30개 전체 README, live/example-dev, CI 워크플로 2개, backlog/decisions 5개, policy/specs/bootstrap/tools README)를 서브에이전트 3개로 나눠 다시 훑은 뒤, README.ko.md를 300줄 mirror 번역에서 71줄 퀵스타트로 재작성. modules->scenarios->live->AWS 흐름, 정직한 현재 상태(AWS 미배포, 시나리오 20/7/3 구분), '먼저 m-22 간단 배포 → 나머지는 학습 자료'라는 우선순위를 명확히 반영. README.md는 변경하지 않음.
<!-- SECTION:FINAL_SUMMARY:END -->
