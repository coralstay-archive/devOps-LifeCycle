---
id: TASK-123
title: '동작 명세: redshift — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:28'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/redshift/spec.tla
documentation:
  - modules/redshift/README.md
type: spike
ordinal: 275000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/redshift/spec.tla — rds-postgres와 똑같이 manage_master_password = true로 AWS가 비밀번호를 관리하지만, 이 모듈은 그 비밀이 담긴 Secrets Manager ARN을 outputs.tf에 아예 노출하지 않는다(endpoint, cluster_id뿐) — rds-postgres보다도 더 추상화된 "관리형 클러스터가 존재한다"만 모델링하는 게 여기서는 더 정직한 표현이다. 이건 실제로 이 모듈의 알려진 한계(README의 "아직 포함 안 된 것" 참고)이기도 하다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
