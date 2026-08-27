---
id: TASK-108
title: '동작 명세: ec2 — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:26'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/ec2/spec.tla
documentation:
  - 'https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RunInstances.html'
type: spike
ordinal: 245000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/ec2/spec.tla — RunInstances 하나의 AWS API 호출로 거의 끝나는, 이 저장소에서 가장 "알고리즘 한 줄"에 가까운 모듈이다 — 그래도 입력 중 하나(ami_id)가 null이면 최신 AL2023 AMI를 조회해서 대신 쓴다는 분기(conditional lookup)가 있다 — 말하자면 "기본값으로 대체하는 한 줄 if문"에 해당한다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
