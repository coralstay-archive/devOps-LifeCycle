<div align="center">

# 🚀 aws-launcher

**Terraform으로 AWS 인프라를 직접 만들어보며 배우는 개인 학습 프로젝트**

![Terraform](https://img.shields.io/badge/terraform-%3E%3D1.5-623CE4?style=flat-square&logo=terraform&logoColor=white)
![AWS Provider](https://img.shields.io/badge/AWS%20provider-~%3E%205.0-FF9900?style=flat-square&logo=amazonaws&logoColor=white)
![Modules](https://img.shields.io/badge/modules-36-2ea44f?style=flat-square)
![Scenarios](https://img.shields.io/badge/scenarios-30-2ea44f?style=flat-square)

</div>

---

## 이 프로젝트는 뭘 하는 곳인가?

Terraform 코드를 세 단계로 나눠서 관리한다.

```
modules/ (부품)  →  scenarios/ (조합 레시피)  →  live/ (실제 배포)
```

- **`modules/`** — VPC, RDS, EKS 같은 하나짜리 작은 부품 (36개)
- **`scenarios/`** — 부품 여러 개를 엮어 만든 "이런 서비스는 이렇게 조합하세요" 예시 (30개, 그 자체로는 배포 안 함)
- **`live/`** — 원하는 시나리오를 복사해서 내 값(이름·리전 등)을 채우고 실제로 배포하는 곳

## 시작하는 법

1. `aws configure`로 AWS 계정 연결
2. `bootstrap/` 적용 — Terraform 상태를 저장할 S3 버킷을 계정당 한 번 생성
3. 첫 배포는 **`canary-deployment`**로 시작하는 걸 추천 — vpc+eks+observability만 있는 가장 단순한 구성이라 부담 없이 처음부터 끝까지 한 번 해보기 좋다
4. `scenarios/canary-deployment`를 `live/내프로젝트`로 복사하고 값 채우기
5. `terraform apply`로 배포, 확인했으면 `terraform destroy`로 정리
6. 익숙해지면 나머지 29개 시나리오 중 원하는 걸 골라 같은 방식으로 진행

## 포함된 것

- **`modules/`(36개)** — VPC, EKS, RDS, Lambda 같은 부품들
- **`scenarios/`(30개)** — 웹/API, 데이터, ML, 메시징 등 카테고리별 조합 예시
- **`specs/`(TLA+ 명세, 31개)** — "배포된 시스템이 시간이 지나도 규칙을 지키는가"를 수학적으로 검증하는 공식 명세
- **`policy/`** — 이 저장소만의 규칙(예: S3 버킷 공개 금지)을 강제하는 정책(OPA/Rego)

## PR을 올리면 자동으로 벌어지는 일

`terraform fmt/validate` → `tflint` → `trivy`/`checkov`(보안 스캔) → `conftest`(자체 정책 검사) → `terraform plan` + 비용 예측(`infracost`)을 PR 코멘트로 남긴다. **`apply`는 자동으로 하지 않는다.**

## 라이선스

MIT
