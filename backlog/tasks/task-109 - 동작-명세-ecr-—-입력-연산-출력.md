---
id: TASK-109
title: '동작 명세: ecr — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:26'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/ecr/spec.tla
documentation:
  - modules/ecr/README.md
type: spike
ordinal: 247000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/ecr/spec.tla — 리포지토리 생성 자체는 단순하지만, lifecycle policy(untagged_image_expiry_days)가 "태그 없는 이미지만" 만료 대상이라는 걸 정확히 표현하는 게 핵심 — 태그된(배포에 실제로 쓰이는) 이미지는 이 정책의 영향을 받지 않는다는 게 이 모듈이 지키는 안전장치다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
