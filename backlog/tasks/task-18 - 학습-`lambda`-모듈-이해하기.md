---
id: TASK-18
title: '학습: `lambda` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:58'
labels:
  - module
  - lambda
milestone: m-3
dependencies: []
references:
  - modules/lambda
documentation:
  - 'https://docs.aws.amazon.com/lambda/latest/dg/welcome.html'
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function
type: spike
ordinal: 35000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 함수형 컴퓨트. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 콜드스타트
- [ ] #2 VPC 연결 시 ENI 지연
- [ ] #3 프로비저닝된 동시성
- [ ] #4 레이어
- [ ] #5 메모리 128~10240MB라는 실제 Lambda 제약을 precondition으로 표현하기
<!-- AC:END -->
