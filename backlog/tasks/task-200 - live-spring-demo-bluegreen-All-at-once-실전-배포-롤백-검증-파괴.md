---
id: TASK-200
title: 'live/spring-demo-bluegreen: All-at-once 실전 배포 + 롤백 검증 + 파괴'
status: To Do
assignee: []
created_date: '2026-09-05 04:08'
labels: []
milestone: m-23
dependencies:
  - TASK-199
  - TASK-193
  - TASK-177
  - TASK-178
type: task
ordinal: 418000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
TASK-199의 opt-in 템플릿을 live/spring-demo-bluegreen으로 복사해 deployment_config_name=ECSAllAtOnce로 실제 terraform apply한다. curl로 무중단 전환을 직접 관찰한 뒤, 의도적으로 깨진 이미지(헬스체크 상시 실패)로 재배포해 auto-rollback이 진짜 발동하는지 확인한다(설정 존재 여부만이 아니라 실제 실패 주입 -- m-22가 plan만이 아니라 진짜 apply/destroy를 검증하는 원칙과 일관). 마지막으로 terraform destroy 후 AWS CLI(aws ecs/rds/elbv2/ec2 describe-*)로 실제 삭제를 이중 확인한다. m-22 TASK-193(rolling 실배포 검증)과 m-19 TASK-177/178(로컬 AWS 접근, state 백엔드)에 의존.
<!-- SECTION:DESCRIPTION:END -->
