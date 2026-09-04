---
id: TASK-188
title: terraform-apply/drift-detect/loadtest 워크플로 일시 비활성화
status: Done
assignee: []
created_date: '2026-09-04 14:56'
updated_date: '2026-09-04 14:56'
labels: []
milestone: m-19
dependencies: []
ordinal: 397000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
AWS OIDC 자격증명(TASK-177~180)이 아직 준비되지 않아 apply/drift-detect/loadtest 워크플로가 실행될 수 없거나(실패) 실행할 이유가 없다. 지금은 terraform-ci.yml만 다루기로 하고, 나머지 3개는 gh workflow disable로 GitHub Actions UI에서 비활성화한다 (파일은 그대로 두고 gh workflow enable로 즉시 재활성화 가능). AWS 크리덴셜 세팅이 끝나면 다시 켠다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 terraform-apply.yml, drift-detect.yml, loadtest.yml이 gh workflow list에서 disabled_manually 상태로 표시된다
- [x] #2 terraform-ci.yml은 active 상태로 그대로 유지된다
<!-- AC:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
gh workflow disable로 terraform-apply, drift-detect, loadtest 3개를 GitHub Actions에서 비활성화 처리(disabled_manually). 파일은 그대로 두었으므로 gh workflow enable로 즉시 재활성화 가능. terraform-ci는 active 상태 유지. AWS OIDC 크리덴셜(TASK-177~180) 준비 후 재활성화 예정.
<!-- SECTION:FINAL_SUMMARY:END -->
