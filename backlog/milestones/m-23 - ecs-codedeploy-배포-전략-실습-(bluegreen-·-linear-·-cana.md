---
id: m-23
title: "ECS CodeDeploy 배포 전략 실습 (Blue/Green · Linear · Canary)"
---

## Description

AWS의 ECS 배포 전략 마이그레이션 가이드(rolling -> blue/green/linear/canary, https://docs.aws.amazon.com/AmazonECS/latest/developerguide/migrate-deployment-strategies.html)를 손으로 직접 실습한다. m-22(Spring Boot Deploy/Destroy Validation)가 rolling 배포만 검증했던 것 위에, CodeDeploy 기반 Blue/Green(all-at-once)·Linear·Canary 세 전략을 같은 앱으로 각각 실전 배포하고, 의도적으로 깨진 이미지를 배포해 auto-rollback이 실제로 발동하는지까지 확인한 뒤 destroy로 정리한다.

조사 결과 modules/ecs-service는 deployment_controller를 노출하지 않아 CodeDeploy가 트래픽을 제어할 수 없고, modules/codedeploy는 all-at-once만 하드코딩돼 있으며 auto-rollback/전후 검증 훅이 없다 -- 이 두 모듈부터 확장해야 실전 배포가 가능하다. scenarios/canary-deployment(EKS+Argo Rollouts)는 이 문서가 말하는 ECS/CodeDeploy 카나리와 무관한 별개 트랙이라 건드리지 않는다(사용자 확인: 'k8s 안쓴다'). 전략별로 live/ 스택 3개를 병렬로 띄워 비교하기로 했다(순차 재사용 아님, AWS 자원 3배 트레이드오프 인지). 과거 스태시에 있던 orphan TASK-190이 codedeploy 모듈 갭을 정확히 진단했지만 milestone/references가 잘못 걸려 있어 그대로 쓰지 않고 이 마일스톤에서 재구성한다(스태시는 그대로 방치).

m-19(TASK-177/178)와 m-22(TASK-193)에 의존 -- AWS 자격증명/state 백엔드/rolling 배포 검증이 끝나야 실제 apply 단계(Story F/G/H)를 시작할 수 있다. 모듈 확장 작업(Story A~E)은 로컬 Terraform 코드 작업이라 그 의존성과 무관하게 지금 바로 시작 가능하다.
