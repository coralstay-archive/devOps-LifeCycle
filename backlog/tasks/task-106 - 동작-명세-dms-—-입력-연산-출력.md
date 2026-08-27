---
id: TASK-106
title: '동작 명세: dms — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:26'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/dms/spec.tla
documentation:
  - modules/dms/README.md
type: spike
ordinal: 241000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/dms/spec.tla — 이 동작을 작성하다가 실제 main.tf의 진짜 갭을 하나 발견했다 — target_engine_name 기본값이 "kafka"이고 target_kafka_broker 기본값이 null인데, 그 조합을 막는 precondition이 없었다(source_port 검증만 있었음). kafka_settings.broker가 null인 채로 apply되면 DMS 엔드포인트 생성 시점에 훨씬 불친절한 에러가 난다 — 그래서 main.tf에 그 정확한 조합을 막는 precondition을 추가했다. 이 스펙의 Precondition은 그 수정된 제약을 그대로 반영한다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
