---
id: TASK-194.2
title: AWS CLI로 자원이 실제로 삭제됐는지 이중 확인
status: To Do
assignee: []
created_date: '2026-09-05 03:26'
labels: []
dependencies: []
parent_task_id: TASK-194
type: task
ordinal: 412000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
terraform destroy의 종료 코드/로그만 믿지 않고, aws ec2 describe-vpcs / aws ecs describe-services / aws elbv2 describe-load-balancers / aws rds describe-db-instances / aws ecr describe-repositories 등으로 live/spring-demo가 만들었던 리소스가 실제로 남아있지 않은지 하나씩 확인한다. 이 결과가 이 milestone(m-22) 전체의 최종 완료 증거가 된다.
<!-- SECTION:DESCRIPTION:END -->
