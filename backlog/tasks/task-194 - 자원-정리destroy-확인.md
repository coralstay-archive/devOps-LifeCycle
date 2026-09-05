---
id: TASK-194
title: 자원 정리(destroy) 확인
status: To Do
assignee: []
created_date: '2026-09-05 03:24'
labels: []
milestone: m-22
dependencies:
  - TASK-193
type: task
ordinal: 403000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
live/spring-demo에서 terraform destroy를 실행한 뒤, terraform이 스스로 보고하는 성공 여부만 믿지 않고 AWS CLI(aws ecs describe-services, aws rds describe-db-instances, aws elbv2 describe-load-balancers, aws ec2 describe-vpcs 등)로 VPC/ALB/ECS 서비스/RDS 인스턴스/ECR 리포지토리가 실제로 남아있지 않은지 직접 확인한다. 이 milestone의 마지막 목적("배포했다가 모든 자원이 지워지는지 확인")이 바로 이 태스크다. RDS는 기본적으로 destroy 시 최종 스냅샷을 만들려다 실패/지연되는 경우가 흔하므로, modules/rds-postgres의 skip_final_snapshot/deletion_protection 설정을 사전에 확인해둔다.
<!-- SECTION:DESCRIPTION:END -->
