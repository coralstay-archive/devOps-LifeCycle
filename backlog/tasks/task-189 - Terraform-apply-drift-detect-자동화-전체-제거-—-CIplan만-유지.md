---
id: TASK-189
title: Terraform apply/drift-detect 자동화 전체 제거 — CI(plan)만 유지
status: In Progress
assignee: []
created_date: '2026-09-04 15:09'
updated_date: '2026-09-04 15:09'
labels: []
milestone: m-19
dependencies: []
references:
  - decision-5
ordinal: 398000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
decision-5에서 결정한 대로, 이 저장소에서 apply(배포) 자동화를 완전히 제거한다. GitHub Actions 워크플로 파일 삭제, 관련 백로그 태스크 정리, README.md/README.ko.md 등 문서에서 apply/drift-detect 관련 서술을 CI(plan)-only 흐름으로 수정하는 작업까지 포함한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 terraform-apply.yml, drift-detect.yml 파일이 저장소에서 삭제된다
- [ ] #2 README.md, README.ko.md에서 terraform-apply.yml/drift-detect.yml을 언급하는 부분이 CI(plan)-only 흐름을 반영하도록 수정된다
- [ ] #3 TASK-179가 plan 롤 하나만 만들도록 범위가 축소된다
- [ ] #4 TASK-180이 AWS_PLAN_ROLE_ARN 시크릿 등록만 남도록 범위가 축소된다 (apply 시크릿 부분 제거)
- [ ] #5 TASK-181, TASK-182 중 apply 전용 항목이 정리(archive)된다
<!-- AC:END -->
