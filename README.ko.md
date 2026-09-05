<div align="center">

[🇺🇸 English](README.md) · **🇰🇷 한국어**

# 🚀 aws-launcher

**AWS를 Terraform으로 직접 만들어보며 배우는 개인 학습 프로젝트** (Claude와 함께 만듦)

![Terraform](https://img.shields.io/badge/terraform-%3E%3D1.5-623CE4?style=flat-square&logo=terraform&logoColor=white)
![AWS Provider](https://img.shields.io/badge/AWS%20provider-~%3E%205.0-FF9900?style=flat-square&logo=amazonaws&logoColor=white)
![Modules](https://img.shields.io/badge/modules-36-2ea44f?style=flat-square)
![Scenarios](https://img.shields.io/badge/scenarios-30-2ea44f?style=flat-square)
![Status](https://img.shields.io/badge/status-active%20learning%20project-yellow?style=flat-square)

</div>

> 📌 이 문서는 짧고 쉬운 요약본이다. 상세한 전체 내용(모듈/시나리오 전체 목록, 품질 지표, TLA+ 명세 등)은 [README.md](README.md)(영어)를 참고할 것.

---

## 1. 이 프로젝트는 뭘 하는 곳인가?

Terraform 코드를 세 단계로 나눠서 관리한다.

```
modules/ (부품, 36개)  →  scenarios/ (조합 레시피, 30개)  →  live/내프로젝트 (진짜 배포)  →  AWS
```

- **`modules/`** — VPC, RDS, EKS 같은 하나짜리 작은 부품
- **`scenarios/`** — 부품 여러 개를 엮어 만든 "이런 서비스는 이렇게 조합하세요" 예시 (그 자체로는 배포 안 함)
- **`live/`** — 원하는 시나리오를 복사해서 내 값(이름·리전 등)을 채우고 실제로 배포하는 곳

## 2. 지금 상태 (솔직하게)

- 이 프로젝트로 AWS에 실제로 뭔가 배포해본 적은 **아직 한 번도 없다.** 로컬 자격증명 설정부터 시작해야 한다.
- `scenarios/` 30개 중: 완전히 동작하는 것 약 20개, 문서화된 제약이 있는 것 7개, **이름만 그럴싸하고 사실상 비어있는 스텁** 3개(`canary-deployment`, `cost-optimized-spot-fleet`, `ml-training-pipeline`) — 이 3개는 이름이 약속하는 걸 아직 못한다.
- GitHub Actions(CI)는 PR마다 코드 검사(`plan`)만 하고, **실제 배포(`apply`)는 절대 자동으로 하지 않는다** — 배포는 항상 사람이 로컬에서 손으로 실행한다.

## 3. 시작하는 법 (이 순서대로)

> **가장 먼저 할 일은 "간단한 배포 한 번 끝까지 해보기"다.** 아래 4번(모듈 36개·시나리오 30개·TLA+ 명세)은 전부 나중에 필요할 때 하나씩 찾아보는 **학습 자료**일 뿐, 지금 다 볼 필요 없다.

1. **로컬 AWS 자격증명 설정** — `aws configure`로 내 AWS 계정 연결 (백로그 `TASK-177`)
2. **`bootstrap/` 한 번 적용** — Terraform 상태를 저장할 S3 버킷을 계정당 한 번만 생성 (`TASK-178`)
3. **간단한 배포 연습** (백로그 마일스톤 `m-22`)
   - Spring Boot 앱 하나 만들어서 로컬 `docker-compose`로 Postgres 붙여 `curl`로 확인
   - `scenarios/standard-web`을 복사해 실제 AWS에 배포
   - 배포된 주소에 `curl`로 진짜 되는지 확인
   - `terraform destroy`로 지우고, AWS CLI로 정말 다 지워졌는지 재확인
4. 여기까지 한 번 끝내면 그다음부터 원하는 시나리오를 골라 `live/내프로젝트`로 복사해서 나만의 프로젝트를 시작하면 된다.

지금 뭘 해야 할지는 `backlog board` 또는 `backlog task list --plain`으로 확인할 것.

## 4. 나머지는 전부 "필요할 때 찾아보는" 학습 자료

- **`modules/`(36개)** — VPC, EKS, RDS, Lambda 같은 부품들
- **`scenarios/`(30개)** — 웹/API, 데이터, ML, 메시징 등 카테고리별 조합 예시
- **`specs/`(TLA+ 명세, 66개)** — "배포된 시스템이 시간이 지나도 규칙을 지키는가"를 수학적으로 검증. 실제로 진짜 버그를 잡은 적도 있음
- **`policy/`** — 이 저장소만의 규칙(예: S3 버킷 공개 금지)을 강제하는 정책

이 학습 태스크들은 전부 백로그 마일스톤 `m-0`~`m-16`에 `To Do` 상태로 일부러 남겨져 있다 — 직접 코드를 타이핑하고 도구를 돌려보는 것 자체가 학습 목적이라, 미리 완료해두지 않는다.

## 5. PR을 올리면 자동으로 벌어지는 일 (한 줄 요약)

`terraform fmt/validate` → `tflint` → `trivy`/`checkov`(보안 스캔) → `conftest`(자체 정책 검사) → `terraform plan` + 비용 예측(`infracost`)을 PR 코멘트로 남긴다. **`apply`는 절대 하지 않는다.**

## 6. 더 자세히 알고 싶다면

- 전체 상세 문서(영어): [README.md](README.md)
- 왜 이렇게 결정했는지: `backlog/decisions/`
- 지금 뭘 하고 있는지: `backlog board`
