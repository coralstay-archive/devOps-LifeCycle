---
id: TASK-105
title: '동작 명세: codedeploy — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:26'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/codedeploy/spec.tla
documentation:
  - modules/codedeploy/README.md
type: spike
ordinal: 239000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/codedeploy/spec.tla — main.tf가 이미 강제하는 "블루/그린 타겟 그룹은 서로 달라야 한다"는 사전조건을 다시 확인한다 — 실제로 이 둘이 같으면 "트래픽을 전환한다"는 배포 전략 자체가 의미를 잃는다(전환할 곳이 없으므로). 이 모듈이 만드는 배포 그룹의 blue/green 전환 로직 자체는 specs/blue-green-deployment/spec.tla가 런타임 관점(활성 타겟 그룹은 항상 정확히 하나)에서 다룬다 — 여기서는 그 전제 조건(서로 다른 두 타겟 그룹)이 배포 시점에 성립하는지를 다룬다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
