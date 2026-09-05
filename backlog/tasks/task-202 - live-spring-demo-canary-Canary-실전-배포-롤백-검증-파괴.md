---
id: TASK-202
title: 'live/spring-demo-canary: Canary 실전 배포 + 롤백 검증 + 파괴'
status: To Do
assignee: []
created_date: '2026-09-05 04:09'
labels: []
milestone: m-23
dependencies:
  - TASK-201
type: task
ordinal: 420000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
TASK-199 템플릿을 live/spring-demo-canary로 복사해 deployment_config_name을 Canary 계열(예: ECSCanary10Percent5Minutes)로 설정해 apply한다. 카나리 구간 동안 curl로 반복 확인하고, 의도적 실패 이미지로 재배포해 카나리 구간에서 승격이 실제로 막히는지 확인한다(참고: TASK-90의 NoPromotionAfterFailure TLA+ 속성과 개념적으로 대응되지만 TLA+ 스펙 자체는 손대지 않는다). destroy 후 AWS CLI로 이중 확인. TASK-201(Linear) 완료 후 진행.
<!-- SECTION:DESCRIPTION:END -->
