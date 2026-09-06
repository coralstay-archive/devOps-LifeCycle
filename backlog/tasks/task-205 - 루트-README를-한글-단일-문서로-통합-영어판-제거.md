---
id: TASK-205
title: '루트 README를 한글 단일 문서로 통합, 영어판 제거'
status: In Progress
assignee: []
created_date: '2026-09-06 01:01'
updated_date: '2026-09-06 01:01'
labels: []
dependencies: []
ordinal: 443000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
사용자 요청: 리드미는 한글만 남기고(짧고 쉽게, TASK-204에서 만든 README.ko.md 스타일 그대로), 나머지 저장소 전체(모듈/시나리오 개별 문서, 코드, 백로그 등)는 계속 영어로 둔다. README.md(기존 영어 상세판)를 README.ko.md의 짧은 한글 내용으로 교체하고, 이제 중복되는 README.ko.md는 삭제해서 README 파일을 하나로 통합한다. m-20(저장소 전체 한->영 번역) 마일스톤과는 반대 방향처럼 보이지만, m-20은 '영어 문서에 섞여든 자잘한 한국어'를 없애는 작업이고 이건 최상위 README 자체의 언어 선택 문제라 별개다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 README.md가 한글, 짧고 쉬운 내용(TASK-204의 README.ko.md와 동일한 수준의 분량/스타일)으로 바뀐다
- [ ] #2 README.ko.md 파일이 삭제된다
- [ ] #3 README.md 안의 언어 스위처 링크(영어/한국어)가 제거된다 (더 이상 영어판이 없으므로)
- [ ] #4 모듈/시나리오 개별 README, 백로그 등 나머지 문서는 변경되지 않는다
<!-- AC:END -->
