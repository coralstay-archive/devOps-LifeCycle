---
id: TASK-35.1
title: '실습: `modules/vpc-endpoints` 코드를 직접 타이핑하며 학습 주석 달기'
status: To Do
assignee: []
created_date: '2026-08-27 05:00'
updated_date: '2026-08-27 06:35'
labels:
  - module
  - vpc-endpoints
  - hands-on
dependencies: []
references:
  - modules/vpc-endpoints/main.tf
parent_task_id: TASK-35
type: task
ordinal: 70000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
이 모듈의 각 리소스 블록을 직접 타이핑(복붙 금지)하면서, 왜 이렇게 썼는지(핵심 개념 + precondition/postcondition 불변식 포함) 학습 주석을 단다. 공식문서를 찾아보며 확실하지 않은 부분을 채운다.

### 실행 검증 (직접 실행 — AWS 자격증명 불필요)

타이핑 + 학습 주석 작성을 마쳤으면, 아래 순서로 실제 툴체인을 하나씩 돌려 결과를 눈으로 확인한다:

```bash
cd modules/vpc-endpoints
terraform init -backend=false   # 프로바이더만 받는다 (원격 상태 없음)
terraform fmt -check            # 포맷 어긋난 부분이 있는지
terraform validate              # HCL 문법 + 참조가 유효한지
tflint --init && tflint         # AWS 특화 규칙(타입, 네이밍, 문서화 등) — 저장소 루트 .tflint.hcl을 자동으로 찾는다
cd ../..
terraform-docs -c .terraform-docs.yml modules/vpc-endpoints && git diff modules/vpc-endpoints/README.md
                                 # 마지막 줄 출력이 없어야 정상 — README의 Inputs/Outputs 표가 코드와 어긋나면 여기서 바로 보인다
checkov -d modules/vpc-endpoints --compact
trivy config modules/vpc-endpoints
                                 # 둘 다 findings가 나올 수 있다 — README의 '아직 포함 안 된 것' 절과 대조해서, 어떤 게 이 단계에서 받아들인 트레이드오프고 어떤 게 진짜 놓친 설정인지 스스로 판단해본다
```

각 도구가 서로 다른 것을 잡아낸다는 걸 직접 확인하는 게 핵심이다: `validate`=문법, `tflint`=AWS 스타일/타입, `terraform-docs`=문서 드리프트, `checkov`/`trivy`=보안·컴플라이언스 설정.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 각 resource/data 블록에 이 리소스가 왜 필요한지 설명하는 주석이 있다
- [ ] #2 precondition/postcondition이 어떤 실제 제약을 표현하는지 설명하는 주석이 있다
- [ ] #3 terraform fmt -check && terraform validate 통과
- [ ] #4 tflint 통과 (경고가 있다면 왜 그런지 설명할 수 있다)
- [ ] #5 terraform-docs 재실행 결과가 README.md와 diff 없음
- [ ] #6 checkov/trivy 결과 중 최소 1개를 골라, 이 단계에서 받아들인 트레이드오프인지 실제로 고쳐야 할 문제인지 README 근거로 설명할 수 있다
<!-- AC:END -->
