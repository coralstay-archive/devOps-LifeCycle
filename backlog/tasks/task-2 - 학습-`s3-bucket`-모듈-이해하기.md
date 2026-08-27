---
id: TASK-2
title: '학습: `s3-bucket` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 04:57'
labels:
  - module
  - s3-bucket
milestone: m-0
dependencies: []
references:
  - modules/s3-bucket
documentation:
  - 'https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html'
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block
type: spike
ordinal: 3000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 객체 스토리지. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 버저닝+수명주기
- [ ] #2 SSE-S3 vs SSE-KMS
- [ ] #3 버킷 정책 vs ACL
- [ ] #4 복제
- [ ] #5 액세스 로깅
- [ ] #6 출력값 precondition
- [ ] #7 mock_provider의 override_resource 필요성
<!-- AC:END -->
