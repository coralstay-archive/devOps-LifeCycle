---
id: TASK-58
title: '학습: `multi-region-active-active` 시나리오 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 05:02'
labels:
  - scenario
  - multi-region-active-active
milestone: m-13
dependencies: []
references:
  - scenarios/multi-region-active-active
documentation:
  - >-
    https://docs.aws.amazon.com/prescriptive-guidance/latest/aws-multi-region-fundamentals/
type: spike
ordinal: 115000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
이 시나리오가 어떤 모듈들을 왜 그렇게 조합했는지 이해한다. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 파고든다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Terraform provider alias 패턴
- [ ] #2 Route53 라우팅 정책으로 실제 트래픽 분산 구현(아직 미포함)
<!-- AC:END -->
