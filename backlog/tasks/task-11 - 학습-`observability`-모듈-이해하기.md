---
id: TASK-11
title: '학습: `observability` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:58'
labels:
  - module
  - observability
milestone: m-1
dependencies: []
references:
  - modules/observability
documentation:
  - >-
    https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/WhatIsCloudWatch.html
  - >-
    https://docs.aws.amazon.com/prometheus/latest/userguide/what-is-Amazon-Managed-Service-Prometheus.html
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_dashboard
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm
type: spike
ordinal: 21000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 모니터링/알람. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 CloudWatch 지표 vs 로그
- [ ] #2 SLO/에러버짓과 알람 연결
- [ ] #3 EKS용 Prometheus/Grafana(AMP/AMG)
- [ ] #4 SNS 토픽 ARN 형태를 postcondition으로 검증하기
<!-- AC:END -->
