---
id: TASK-33
title: '학습: `aws-backup` 모듈 이해하기'
status: To Do
assignee: []
created_date: '2026-08-27 05:00'
labels:
  - module
  - aws-backup
milestone: m-5
dependencies: []
references:
  - modules/aws-backup
documentation:
  - 'https://docs.aws.amazon.com/aws-backup/latest/devguide/whatisbackup.html'
  - >-
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_plan
type: spike
ordinal: 65000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
핵심 개념: 백업 정책. 공식문서를 찾아보며 아래 학습 포인트를 하나씩 이해하고, 이 모듈의 코드를 직접 읽고 타이핑하며 배운다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 백업 계획/보관정책
- [ ] #2 태그기반 vs ARN기반 선택
- [ ] #3 크로스리전 복사
- [ ] #4 AWS Backup 규칙의 lifecycle{}과 Terraform 메타인수 lifecycle{}이 이름만 같고 다른 개념이라는 것
<!-- AC:END -->
