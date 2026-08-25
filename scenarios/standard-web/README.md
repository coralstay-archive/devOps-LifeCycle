# standard-web

**카테고리**: 웹/API
**설명**: ALB+ECS Fargate+RDS+S3 조합의 일반적인 웹 서비스. 최초 예시(live/example-dev)의 축소판 대상.

## 상태

composed — `vpc`, `ecr`, `alb`, `ecs-service`, `rds-postgres`, `observability` 모듈을 실제로 조합했고 `terraform validate` 통과. `container_image` 기본값은 즉시 plan/apply해볼 수 있도록 공개 nginx 이미지로 채워뒀다 — 실제 앱을 배포하려면 `ecr` 모듈이 만든 리포지토리에 이미지를 푸시하고 `container_image` 변수를 그 URL로 바꿀 것.

## 관련 모듈

vpc, ecr, alb, ecs-service, rds-postgres, observability

## 사용 방법

`live/<project-name>/`으로 복사한 뒤 그 프로젝트만의 `terraform.tfvars`와 `backend.tf`를 채워 넣는다.

## 참고자료

- [AWS Well-Architected Framework](https://docs.aws.amazon.com/wellarchitected/latest/framework/welcome.html)
- 관련 모듈 문서: `vpc`, `ecr`, `alb`, `ecs-service`, `rds-postgres`, `observability`
