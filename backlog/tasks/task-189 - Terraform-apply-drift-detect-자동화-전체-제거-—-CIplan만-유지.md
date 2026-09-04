---
id: TASK-189
title: Terraform apply/drift-detect 자동화 전체 제거 — CI(plan)만 유지
status: Done
assignee: []
created_date: '2026-09-04 15:09'
updated_date: '2026-09-04 15:15'
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
- [x] #1 terraform-apply.yml, drift-detect.yml 파일이 저장소에서 삭제된다
- [x] #2 README.md, README.ko.md에서 terraform-apply.yml/drift-detect.yml을 언급하는 부분이 CI(plan)-only 흐름을 반영하도록 수정된다
- [x] #3 TASK-179가 plan 롤 하나만 만들도록 범위가 축소된다
- [x] #4 TASK-180이 AWS_PLAN_ROLE_ARN 시크릿 등록만 남도록 범위가 축소된다 (apply 시크릿 부분 제거)
- [x] #5 TASK-181, TASK-182 중 apply 전용 항목이 정리(archive)된다
<!-- AC:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
terraform-apply.yml, drift-detect.yml 삭제(loadtest.yml은 apply와 무관해 유지). README.md/README.ko.md/modules/iam-github-oidc README를 plan-only 흐름으로 갱신. TASK-179/180을 plan 롤 1개 기준으로 재작성, TASK-181의 apply/drift 서브태스크 및 TASK-182(+하위 182.1/182.2) 전부 archive. m-19 마일스톤 설명도 plan-only로 재기술. decision-5에 근거/트레이드오프 기록. 전체 grep 검증 결과 backlog/ 밖에는 의도된 'No apply role' 문구 한 줄만 남고 stale 참조 없음.
<!-- SECTION:FINAL_SUMMARY:END -->
