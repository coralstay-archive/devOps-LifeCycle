---
id: TASK-125
title: '동작 명세: s3-bucket — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:28'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/s3-bucket/spec.tla
documentation:
  - 'https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html'
type: spike
ordinal: 279000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/s3-bucket/spec.tla — 이 모듈이 실제로 보장하는 건 뭘까 — variables.tf가 입력, main.tf가 실행하는 AWS API 호출들이 연산, outputs.tf가 출력이라고 보면, s3-bucket의 핵심 동작은 "옵션으로 껐다 켰다 할 수 있는 게 하나도 없이, 암호화와 퍼블릭 액세스 차단은 항상 걸려 있다"는 것이다. 이 방식을 모든 modules/*에 쓰는 이유와, TLC로 검증해도 왜 "증명"이 아니라 "한 예시 확인"인지는 specs/modules/README.md에 한 번만 정리해뒀다 — 이 파일은 그 형태를 실제 TLA+로 어떻게 쓰는지 보여주는 템플릿이다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
