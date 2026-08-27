---
id: TASK-66
title: '학습: `cost-optimized-spot-fleet` 시나리오 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 05:03'
labels:
  - scenario
  - cost-optimized-spot-fleet
milestone: m-15
dependencies: []
references:
  - scenarios/cost-optimized-spot-fleet
documentation:
  - >-
    https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-spot-instances.html
  - >-
    https://docs.aws.amazon.com/AmazonECS/latest/developerguide/fargate-capacity-providers.html
type: spike
ordinal: 131000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
이 시나리오가 어떤 모듈들을 왜 그렇게 조합했는지 이해한다. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 파고든다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Fargate Spot/EC2 Spot 중단 처리
- [ ] #2 `capacity_provider_strategy` 직접 추가해보기(아직 미포함)
<!-- AC:END -->
