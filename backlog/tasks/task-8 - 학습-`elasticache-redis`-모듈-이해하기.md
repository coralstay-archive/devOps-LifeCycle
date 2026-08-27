---
id: TASK-8
title: '학습: `elasticache-redis` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:58'
labels:
  - module
  - elasticache-redis
milestone: m-1
dependencies: []
references:
  - modules/elasticache-redis
documentation:
  - 'https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/WhatIs.html'
  - 'https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Strategies.html'
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group
type: spike
ordinal: 15000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 인메모리 캐시. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 복제그룹 vs Cluster Mode(샤딩)
- [ ] #2 자동 페일오버
- [ ] #3 읽기 리플리카로 스케일링
- [ ] #4 num_cache_nodes 최소값 precondition
<!-- AC:END -->
