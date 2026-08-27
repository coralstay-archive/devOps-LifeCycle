---
id: TASK-126
title: '동작 명세: sagemaker — 입력/연산/출력'
status: To Do
assignee: []
created_date: '2026-08-27 14:28'
updated_date: '2026-08-27 14:30'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/modules/sagemaker/spec.tla
documentation:
  - modules/sagemaker/README.md
type: spike
ordinal: 281000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/sagemaker/spec.tla — 실시간 추론 엔드포인트가 나오려면 반드시 model_data_url(학습된 아티팩트)과 container_image(서빙 코드)가 둘 다 있어야 한다 — 이 관계형 ML 배포 파이프라인 자체는 specs/ml-realtime-inference/spec.tla가 런타임 관점(blue/green 무중단 갱신)에서 다루고, 여기서는 배포 시점의 입력 동작만 다룬다.

공식문서를 찾아보며 왜 이런 동작이 실제 AWS 서비스의 제약에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 모듈의 입력(variables.tf)과 연산(main.tf가 호출하는 AWS API), 출력(outputs.tf)의 관계를 자신의 말로 설명할 수 있다
- [ ] #2 Postcondition이 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
<!-- AC:END -->
