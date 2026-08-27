---
id: TASK-95.1
title: '학습: CloudFront 무효화(Invalidation)와 캐시 정책'
status: To Do
assignee: []
created_date: '2026-08-27 06:19'
labels: []
dependencies: []
documentation:
  - 'https://lamport.azurewebsites.net/tla/tla.html'
parent_task_id: TASK-95
type: docs
ordinal: 190000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Amazon CloudFront 공식 문서에서 무효화(invalidation) 요청의 실제 전파 지연과, TTL 기반 캐시 정책(CachePolicy)의 차이를 읽고, 이 스펙에 stale-while-revalidate(재검증 중에도 잠깐 stale 콘텐츠를 서빙) 동작을 추가하려면 NoServingInvalidatedAsHit 불변식을 어떻게 완화해야 할지 생각해본다.
<!-- SECTION:DESCRIPTION:END -->
