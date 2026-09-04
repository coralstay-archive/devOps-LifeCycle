---
id: decision-5
title: Terraform apply/deploy 자동화 전체 제거 — CI(plan/검증)만 유지
date: '2026-09-04 15:08'
status: accepted
---
## Context

`terraform-apply.yml`(main 머지 시 자동 apply)과 `drift-detect.yml`(배포된 인프라의 drift 감지)은 m-19 마일스톤의 일부로 설계됐지만, 실행 전제인 AWS OIDC 자격증명 체인(TASK-177~180)이 아직 갖춰지지 않았다. 게다가 `terraform-apply.yml`이 의존하는 `production` GitHub Environment의 필수 리뷰어(수동 승인 게이트)도 저장소에 설정돼 있지 않다는 게 이번에 확인됐다 — 즉 문서/워크플로 주석이 약속하는 안전장치가 실제로는 비어 있었다.

이 프로젝트는 개인 학습 목적(README 서두 참고)이라 실제 AWS 리소스를 CI가 자동으로 만들고 부수는 흐름 자체가 지금 단계에서 불필요한 리스크와 복잡도(수동 승인 리뷰어 설정, apply 전용 IAM 롤, drift 추적)를 더한다는 판단.

## Decision

이 저장소에서 Terraform **apply(배포) 자동화를 전부 제거**한다. GitHub Actions에는 PR 검증(`terraform-ci.yml`: fmt/validate/tflint/trivy/checkov/conftest/terraform test/plan)만 남기고, `terraform-apply.yml`과 `drift-detect.yml`은 삭제한다. 실제 배포가 필요하면 로컬에서 수동으로 `terraform apply`한다.

이에 따라 IAM OIDC 설계(TASK-179)도 plan 롤 하나만 만들도록 축소하고, apply 롤 생성/시크릿 등록/트러스트 정책 강화(TASK-180의 apply 부분, TASK-181.2/181.3, TASK-182)는 더 이상 필요 없으므로 백로그에서 정리한다.

## Consequences

- CI가 여전히 `terraform plan`까지는 수행하므로(코드 검증 목적), plan 롤(`AWS_PLAN_ROLE_ARN`) 하나는 여전히 필요하다 — TASK-177~180 체인 자체가 없어지는 건 아니고 범위만 줄어든다.
- `live/example-dev`를 실제로 배포/갱신하려면 사람이 로컬에서 `terraform apply`를 직접 실행해야 하며, 그 결과가 실제 인프라와 code 사이에 벌어져도(drift) 자동으로 감지되지 않는다 — 이건 의도된 트레이드오프다.
- 나중에 이 프로젝트가 "실제로 뭔가를 계속 띄워두는" 단계로 넘어가면 이 결정을 재검토하고 apply/drift-detect를 다시 설계해 넣어야 한다.
- README.md/README.ko.md 등 문서에서 "merge to main → terraform-apply.yml applies" 흐름을 서술한 부분은 모두 수정이 필요하다.

