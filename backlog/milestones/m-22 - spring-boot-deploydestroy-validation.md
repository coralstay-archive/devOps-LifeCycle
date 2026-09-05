---
id: m-22
title: "Spring Boot Deploy/Destroy Validation"
---

## Description

간단한 배포 파이프라인을 사람이 손으로 처음부터 끝까지 검증한다: Spring Boot 앱을 로컬에서 docker-compose로 Postgres에 붙여 curl로 확인 -> ECR에 이미지 푸시 -> scenarios/standard-web을 live/spring-demo로 복사해 실제 AWS(VPC+ECR+ALB+ECS Fargate+RDS Postgres+observability)로 terraform apply -> ALB 엔드포인트를 curl로 확인 -> terraform destroy로 모든 자원이 실제로 정리되는지까지 확인. RDS는 rds-postgres 모듈(관리형)을 그대로 쓰고, 도커 Postgres는 로컬 개발/테스트 전용 -- AWS에 도커로 DB를 올리는 게 아니다.

CI는 관여하지 않는다 -- decision-5에 따라 이 저장소는 apply를 자동화하지 않으므로, apply/destroy는 전부 사람이 로컬 터미널에서 직접 실행한다.

m-19(AWS Bootstrap & CI Credential Wiring)의 TASK-177(로컬 AWS 접근)과 TASK-178(bootstrap 적용으로 Terraform state 백엔드 생성)에 의존한다 -- 이 milestone 생성 시점에 둘 다 아직 To Do라, AWS apply/destroy 단계는 그 완료 전까지 실행할 수 없다. Spring Boot 앱 개발과 로컬 docker-compose 검증은 그 의존성과 무관하게 먼저 진행 가능하다.
