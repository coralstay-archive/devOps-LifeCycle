---
id: TASK-193
title: AWS 실배포 및 curl 검증
status: To Do
assignee: []
created_date: '2026-09-05 03:24'
labels: []
milestone: m-22
dependencies:
  - TASK-192
type: task
ordinal: 402000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
live/spring-demo에서 terraform init && terraform plan && terraform apply를 사람이 로컬에서 직접 실행한다 (decision-5에 따라 CI는 apply를 자동화하지 않음). apply 결과로 나온 ALB DNS(output alb_dns_name)에 curl로 health-check 엔드포인트와 Postgres 연동 엔드포인트를 실제로 호출해 응답을 확인한다 -- 이게 이 milestone 전체의 핵심 목적(스프링부트+RDS 조합이 AWS에서 실제로 동작하는지)이다. TASK-181.1(real PR로 plan 검증)과는 별개로, 여긴 실제 apply까지 수행하는 지점.
<!-- SECTION:DESCRIPTION:END -->
