---
id: TASK-130
title: '동작 명세: vpc — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:29'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/vpc/spec.tla
documentation:
  - 'https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html'
type: spike
ordinal: 289000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/vpc/spec.tla — availability_zones가 리스트이고, public/private 서브넷과 라우트 테이블이 "AZ 개수만큼" 만들어진다 — 알고리즘으로 치면 루프(for each AZ) + 배열 인덱싱에 해당한다. TLA+에서는 이런 "AZ별 1개씩" 관계를 시퀀스(Seq)와 그 Len()으로 정확히 표현할 수 있다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
