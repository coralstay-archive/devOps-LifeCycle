---
id: TASK-192
title: live/spring-demo 스캐폴딩 + ECR 이미지 푸시
status: To Do
assignee: []
created_date: '2026-09-05 03:24'
updated_date: '2026-09-05 03:24'
labels: []
milestone: m-22
dependencies:
  - TASK-191
  - TASK-178
  - TASK-177
type: task
ordinal: 401000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
scenarios/standard-web(vpc+ecr+alb+ecs-service+rds-postgres+observability)을 live/spring-demo로 복사하고, 그 프로젝트만의 backend.tf(TASK-178이 만드는 state 버킷 이름 사용)와 terraform.tfvars/변수를 채운다. TASK-191에서 빌드한 이미지를 ecr 모듈이 만드는 리포지토리로 aws ecr get-login-password 방식으로 푸시하고, container_image 변수를 그 실제 URL로 교체한다 (지금 기본값은 public.ecr.aws/nginx/nginx). ECR 푸시는 로컬 AWS 자격증명(TASK-177)이 필요하다.
<!-- SECTION:DESCRIPTION:END -->
