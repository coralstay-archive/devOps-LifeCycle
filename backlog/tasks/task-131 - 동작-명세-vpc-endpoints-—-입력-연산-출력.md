---
id: TASK-131
title: '동작 명세: vpc-endpoints — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:29'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/vpc-endpoints/spec.tla
documentation:
  - modules/vpc-endpoints/README.md
type: spike
ordinal: 291000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/vpc-endpoints/spec.tla — interface_services 목록으로 넘긴 서비스 각각이 반드시 인터페이스 엔드포인트로 만들어져야 한다는 게 핵심 동작 — 하나라도 빠지면 그 서비스(예: ecr.dkr)로 가는 트래픽이 private-vpc-only 시나리오에서 여전히 인터넷/NAT 경로를 타게 되어, "프라이빗 전용"이라는 전제 자체가 조용히 깨진다. 이건 specs/private-vpc-only/spec.tla가 런타임 관점(인터넷 게이트웨이 경로 부재)에서 다루는 것과 짝을 이루는, 배포 시점 계약이다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
