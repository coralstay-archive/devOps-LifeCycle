---
id: TASK-203
title: README Learning backlog 섹션을 현재 백로그 상태와 동기화
status: In Progress
assignee: []
created_date: '2026-09-05 04:43'
updated_date: '2026-09-05 04:43'
labels: []
dependencies:
  - TASK-189
references:
  - decision-5
ordinal: 441000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
README.md의 'Learning backlog' 섹션(약 291행)이 m-19의 실제 상태(TASK-182 archive, TASK-188/189 추가로 인해 story 구성이 TASK-177~182에서 TASK-177~181+188/189로 바뀌었고 Status도 0/6에서 2/7로 바뀜)와 어긋나 있고, m-20/m-22/m-23 마일스톤은 README.md·README.ko.md 어디에도 전혀 언급되지 않는다(grep으로 확인, 완전 부재). README.md가 이 저장소의 유일한 온보딩/전체-워크플로 설명 문서라서(CONTRIBUTING.md/docs/ 등 없음, 다른 README들은 서브시스템 전용 기술 문서일 뿐) 이걸 최신 상태로 유지하는 게 중요하다. README.ko.md는 한술 더 떠 m-18 항목조차 빠져 있고, 마지막 표 아래 '17개(+엔지니어링 백로그 1개)' 문구도 stale하다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 README.md의 m-19 항목이 현재 story 구성(TASK-177~181, 188, 189)과 Status(2/7 done)를 정확히 반영한다
- [ ] #2 README.md에 m-20, m-22, m-23 마일스톤 항목이 m-17/m-18과 같은 문체로 추가된다
- [ ] #3 README.ko.md에 m-18, m-19(교정된 내용), m-20, m-22, m-23 항목이 모두 번역되어 추가된다
- [ ] #4 README.ko.md의 마지막 표 아래 마일스톤 개수 문구가 stale하지 않도록 갱신된다
- [ ] #5 backlog milestone list의 실제 done/total 숫자와 두 README에 적은 숫자가 일치한다
<!-- AC:END -->
