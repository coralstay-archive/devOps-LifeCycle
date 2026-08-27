---
id: TASK-43.1
title: '실습: `scenarios/data-lake` 코드를 직접 타이핑하며 학습 주석 달기'
status: To Do
assignee: []
created_date: '2026-08-27 05:01'
updated_date: '2026-08-27 06:35'
labels:
  - scenario
  - data-lake
  - hands-on
dependencies: []
references:
  - scenarios/data-lake/main.tf
parent_task_id: TASK-43
type: task
ordinal: 86000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
main.tf의 모듈 조합 부분을 직접 타이핑하면서, 어떤 모듈을 왜 이 순서/방식으로 연결했는지 학습 주석을 단다.

### 실행 검증 (직접 실행 — AWS 자격증명 불필요)

모듈 조합 부분을 타이핑하고 주석을 단 뒤, 아래 순서로 실제 툴체인을 돌려 결과를 눈으로 확인한다:

```bash
cd scenarios/data-lake
terraform init -backend=false   # 프로바이더만 받는다 (시나리오는 상태를 갖지 않는다)
terraform fmt -check
terraform validate              # 모듈 소스 경로, 변수 타입, 출력값 참조가 다 맞물리는지
tflint --init && tflint
cd ../..
terraform-docs -c .terraform-docs.yml scenarios/data-lake && git diff scenarios/data-lake/README.md
                                 # 마지막 줄 출력이 없어야 정상
checkov -d scenarios/data-lake --compact
trivy config scenarios/data-lake
```

(선택, 본인 AWS 계정/자격증명이 있는 경우에만) 실제 plan을 만들어 이 저장소 고유 정책(`policy/*.rego`)까지 검증해본다 — 비용이 들지 않는 `plan`만 실행하고 `apply`는 하지 않는다:

```bash
cd scenarios/data-lake
terraform plan -out=tfplan
terraform show -json tfplan | conftest test --policy ../../policy -
```

자격증명이 없다면 이 마지막 단계는 건너뛰어도 된다 — `validate`/`tflint`/`terraform-docs`/`checkov`/`trivy`까지가 이 태스크의 필수 범위다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 모듈 간 출력값->입력값 연결 부분에 왜 이렇게 연결했는지 설명하는 주석이 있다
- [ ] #2 terraform fmt -check && terraform validate 통과
- [ ] #3 tflint 통과 (경고가 있다면 왜 그런지 설명할 수 있다)
- [ ] #4 terraform-docs 재실행 결과가 README.md와 diff 없음
- [ ] #5 checkov/trivy 결과 중 최소 1개를 골라, 이 단계에서 받아들인 트레이드오프인지 실제로 고쳐야 할 문제인지 README 근거로 설명할 수 있다
<!-- AC:END -->
