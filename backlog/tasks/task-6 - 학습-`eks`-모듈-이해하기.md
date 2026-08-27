---
id: TASK-6
title: '학습: `eks` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:57'
labels:
  - module
  - eks
milestone: m-1
dependencies: []
references:
  - modules/eks
documentation:
  - 'https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html'
  - 'https://docs.aws.amazon.com/eks/latest/best-practices/karpenter.html'
  - 'https://karpenter.sh/docs/'
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster
type: spike
ordinal: 11000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 관리형 쿠버네티스. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 컨트롤플레인/노드그룹 구조
- [ ] #2 **Karpenter vs Cluster Autoscaler**
- [ ] #3 IRSA
- [ ] #4 프라이빗 API 엔드포인트
- [ ] #5 노드그룹 스케일링 범위(min<=desired<=max)를 precondition으로 검증하기
<!-- AC:END -->
