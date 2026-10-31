<!-- work-order-hash: 51fec45e3d4287e1e6605355dba0370b6a270d6cc593dba796d7004588af48d6 -->
# 작업 순서

`work_order.py`가 backlog/tasks의 의존(`dependencies`)으로 만든 파일이다 — 직접 고치지 말고 다시 생성한다. 같은 단계의 태스크는 병렬로, 단계는 위에서 아래로 순차로 진행한다. Done 태스크와 없는 태스크에 대한 의존은 충족된 것으로 본다.

| 단계 | ID | 제목 |
|---|---|---|
| 1 | TASK-1 | 학습: `vpc` 모듈 이해하기 |
| 1 | TASK-1.1 | 실습: `modules/vpc` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-2 | 학습: `s3-bucket` 모듈 이해하기 |
| 1 | TASK-2.1 | 실습: `modules/s3-bucket` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-3 | 학습: `iam-github-oidc` 모듈 이해하기 |
| 1 | TASK-3.1 | 실습: `modules/iam-github-oidc` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-4 | 학습: `iam` 모듈 이해하기 |
| 1 | TASK-4.1 | 실습: `modules/iam` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-5 | 학습: `ec2` 모듈 이해하기 |
| 1 | TASK-5.1 | 실습: `modules/ec2` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-6 | 학습: `eks` 모듈 이해하기 |
| 1 | TASK-6.1 | 실습: `modules/eks` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-7 | 학습: `ecs-service` 모듈 이해하기 |
| 1 | TASK-7.1 | 실습: `modules/ecs-service` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-8 | 학습: `elasticache-redis` 모듈 이해하기 |
| 1 | TASK-8.1 | 실습: `modules/elasticache-redis` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-9 | 학습: `msk-kafka` 모듈 이해하기 |
| 1 | TASK-9.1 | 실습: `modules/msk-kafka` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-10 | 학습: `rds-postgres` 모듈 이해하기 |
| 1 | TASK-10.1 | 실습: `modules/rds-postgres` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-11 | 학습: `observability` 모듈 이해하기 |
| 1 | TASK-11.1 | 실습: `modules/observability` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-12 | 학습: `alb` 모듈 이해하기 |
| 1 | TASK-12.1 | 실습: `modules/alb` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-13 | 학습: `acm` 모듈 이해하기 |
| 1 | TASK-13.1 | 실습: `modules/acm` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-14 | 학습: `route53` 모듈 이해하기 |
| 1 | TASK-14.1 | 실습: `modules/route53` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-15 | 학습: `kms` 모듈 이해하기 |
| 1 | TASK-15.1 | 실습: `modules/kms` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-16 | 학습: `secrets-manager` 모듈 이해하기 |
| 1 | TASK-16.1 | 실습: `modules/secrets-manager` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-17 | 학습: `ecr` 모듈 이해하기 |
| 1 | TASK-17.1 | 실습: `modules/ecr` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-18 | 학습: `lambda` 모듈 이해하기 |
| 1 | TASK-18.1 | 실습: `modules/lambda` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-19 | 학습: `dynamodb` 모듈 이해하기 |
| 1 | TASK-19.1 | 실습: `modules/dynamodb` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-20 | 학습: `api-gateway` 모듈 이해하기 |
| 1 | TASK-20.1 | 실습: `modules/api-gateway` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-21 | 학습: `sns-sqs` 모듈 이해하기 |
| 1 | TASK-21.1 | 실습: `modules/sns-sqs` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-22 | 학습: `eventbridge` 모듈 이해하기 |
| 1 | TASK-22.1 | 실습: `modules/eventbridge` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-23 | 학습: `cloudfront` 모듈 이해하기 |
| 1 | TASK-23.1 | 실습: `modules/cloudfront` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-24 | 학습: `glue` 모듈 이해하기 |
| 1 | TASK-24.1 | 실습: `modules/glue` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-25 | 학습: `athena` 모듈 이해하기 |
| 1 | TASK-25.1 | 실습: `modules/athena` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-26 | 학습: `redshift` 모듈 이해하기 |
| 1 | TASK-26.1 | 실습: `modules/redshift` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-27 | 학습: `dms` 모듈 이해하기 |
| 1 | TASK-27.1 | 실습: `modules/dms` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-28 | 학습: `step-functions` 모듈 이해하기 |
| 1 | TASK-28.1 | 실습: `modules/step-functions` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-29 | 학습: `sagemaker` 모듈 이해하기 |
| 1 | TASK-29.1 | 실습: `modules/sagemaker` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-30 | 학습: `bedrock-opensearch` 모듈 이해하기 |
| 1 | TASK-30.1 | 실습: `modules/bedrock-opensearch` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-31 | 학습: `organizations-landing-zone` 모듈 이해하기 |
| 1 | TASK-31.1 | 실습: `modules/organizations-landing-zone` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-32 | 학습: `waf-shield` 모듈 이해하기 |
| 1 | TASK-32.1 | 실습: `modules/waf-shield` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-33 | 학습: `aws-backup` 모듈 이해하기 |
| 1 | TASK-33.1 | 실습: `modules/aws-backup` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-34 | 학습: `codedeploy` 모듈 이해하기 |
| 1 | TASK-34.1 | 실습: `modules/codedeploy` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-35 | 학습: `vpc-endpoints` 모듈 이해하기 |
| 1 | TASK-35.1 | 실습: `modules/vpc-endpoints` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-36 | 학습: `amazon-mq` 모듈 이해하기 |
| 1 | TASK-36.1 | 실습: `modules/amazon-mq` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-37 | 학습: `standard-web` 시나리오 이해하기 |
| 1 | TASK-37.1 | 실습: `scenarios/standard-web` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-38 | 학습: `high-traffic-spike` 시나리오 이해하기 |
| 1 | TASK-38.1 | 실습: `scenarios/high-traffic-spike` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-39 | 학습: `serverless-api` 시나리오 이해하기 |
| 1 | TASK-39.1 | 실습: `scenarios/serverless-api` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-40 | 학습: `static-site-cdn` 시나리오 이해하기 |
| 1 | TASK-40.1 | 실습: `scenarios/static-site-cdn` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-41 | 학습: `multi-tenant-saas` 시나리오 이해하기 |
| 1 | TASK-41.1 | 실습: `scenarios/multi-tenant-saas` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-42 | 학습: `real-time-streaming` 시나리오 이해하기 |
| 1 | TASK-42.1 | 실습: `scenarios/real-time-streaming` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-43 | 학습: `data-lake` 시나리오 이해하기 |
| 1 | TASK-43.1 | 실습: `scenarios/data-lake` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-44 | 학습: `data-warehouse` 시나리오 이해하기 |
| 1 | TASK-44.1 | 실습: `scenarios/data-warehouse` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-45 | 학습: `cdc-pipeline` 시나리오 이해하기 |
| 1 | TASK-45.1 | 실습: `scenarios/cdc-pipeline` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-46 | 학습: `etl-batch` 시나리오 이해하기 |
| 1 | TASK-46.1 | 실습: `scenarios/etl-batch` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-47 | 학습: `read-heavy-caching` 시나리오 이해하기 |
| 1 | TASK-47.1 | 실습: `scenarios/read-heavy-caching` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-48 | 학습: `session-store` 시나리오 이해하기 |
| 1 | TASK-48.1 | 실습: `scenarios/session-store` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-49 | 학습: `event-driven-microservices` 시나리오 이해하기 |
| 1 | TASK-49.1 | 실습: `scenarios/event-driven-microservices` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-50 | 학습: `pub-sub-fanout` 시나리오 이해하기 |
| 1 | TASK-50.1 | 실습: `scenarios/pub-sub-fanout` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-51 | 학습: `scheduled-batch-jobs` 시나리오 이해하기 |
| 1 | TASK-51.1 | 실습: `scenarios/scheduled-batch-jobs` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-52 | 학습: `ml-training-pipeline` 시나리오 이해하기 |
| 1 | TASK-52.1 | 실습: `scenarios/ml-training-pipeline` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-53 | 학습: `ml-realtime-inference` 시나리오 이해하기 |
| 1 | TASK-53.1 | 실습: `scenarios/ml-realtime-inference` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-54 | 학습: `llm-rag-service` 시나리오 이해하기 |
| 1 | TASK-54.1 | 실습: `scenarios/llm-rag-service` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-55 | 학습: `multi-account-landing-zone` 시나리오 이해하기 |
| 1 | TASK-55.1 | 실습: `scenarios/multi-account-landing-zone` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-56 | 학습: `private-vpc-only` 시나리오 이해하기 |
| 1 | TASK-56.1 | 실습: `scenarios/private-vpc-only` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-57 | 학습: `zero-trust-edge` 시나리오 이해하기 |
| 1 | TASK-57.1 | 실습: `scenarios/zero-trust-edge` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-58 | 학습: `multi-region-active-active` 시나리오 이해하기 |
| 1 | TASK-58.1 | 실습: `scenarios/multi-region-active-active` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-59 | 학습: `disaster-recovery-pilot-light` 시나리오 이해하기 |
| 1 | TASK-59.1 | 실습: `scenarios/disaster-recovery-pilot-light` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-60 | 학습: `backup-restore-baseline` 시나리오 이해하기 |
| 1 | TASK-60.1 | 실습: `scenarios/backup-restore-baseline` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-61 | 학습: `eks-multi-tenant-cluster` 시나리오 이해하기 |
| 1 | TASK-61.1 | 실습: `scenarios/eks-multi-tenant-cluster` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-62 | 학습: `ecs-fargate-microservices` 시나리오 이해하기 |
| 1 | TASK-62.1 | 실습: `scenarios/ecs-fargate-microservices` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-63 | 학습: `blue-green-deployment` 시나리오 이해하기 |
| 1 | TASK-63.1 | 실습: `scenarios/blue-green-deployment` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-64 | 학습: `canary-deployment` 시나리오 이해하기 |
| 1 | TASK-64.1 | 실습: `scenarios/canary-deployment` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-65 | 학습: `observability-only-baseline` 시나리오 이해하기 |
| 1 | TASK-65.1 | 실습: `scenarios/observability-only-baseline` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-66 | 학습: `cost-optimized-spot-fleet` 시나리오 이해하기 |
| 1 | TASK-66.1 | 실습: `scenarios/cost-optimized-spot-fleet` 코드를 직접 타이핑하며 학습 주석 달기 |
| 1 | TASK-67 | TLA+ 명세: standard-web — ALB 헬스체크 상태 머신과 NoResurrection 불변식 |
| 1 | TASK-67.1 | 학습: ghost(history) 변수로 안전 속성 표현하기 — TLA+ Video Course 참고 |
| 1 | TASK-67.2 | 실습: `specs/standard-web/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-68 | TLA+ 명세: real-time-streaming — MSK 파티션 순서 보장과 NoReadingUnwrittenMessages |
| 1 | TASK-68.1 | 학습: Kafka 파티션의 순서 보장과 컨슈머 오프셋 |
| 1 | TASK-68.2 | 실습: `specs/real-time-streaming/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-69 | TLA+ 명세: data-lake — Glue Crawler/카탈로그 순서와 NoQueryBeforeCatalog |
| 1 | TASK-69.1 | 학습: TLA+에서 '일어나면 안 되는 전이'를 표현하는 법 |
| 1 | TASK-69.2 | 실습: `specs/data-lake/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-70 | TLA+ 명세: data-warehouse — Redshift COPY 트랜잭션 원자성과 AllOrNothingCommit |
| 1 | TASK-70.1 | 학습: 트랜잭션 원자성을 상태 변수로 표현하는 법 |
| 1 | TASK-70.2 | 실습: `specs/data-warehouse/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-71 | TLA+ 명세: cdc-pipeline — DMS Full Load -> CDC 순서와 NoOutOfOrderApply |
| 1 | TASK-71.1 | 학습: DMS Full Load와 CDC의 실제 버퍼링 동작 |
| 1 | TASK-71.2 | 실습: `specs/cdc-pipeline/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-72 | TLA+ 명세: etl-batch — Step Functions 재시도 상태 머신과 BoundedRetries |
| 1 | TASK-72.1 | 학습: Step Functions Retry의 BackoffRate/IntervalSeconds |
| 1 | TASK-72.2 | 실습: `specs/etl-batch/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-73 | TLA+ 명세: read-heavy-caching — cache-aside 패턴과 NoStaleReadWhenValid |
| 1 | TASK-73.1 | 학습: cache-aside vs write-through 캐싱 전략 |
| 1 | TASK-73.2 | 실습: `specs/read-heavy-caching/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-74 | TLA+ 명세: session-store — TTL 만료와 ExpiredIsNeverActive |
| 1 | TASK-74.1 | 학습: Redis TTL과 EXPIRE/PERSIST 명령 |
| 1 | TASK-74.2 | 실습: `specs/session-store/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-75 | TLA+ 명세: event-driven-microservices — SQS at-least-once와 IdempotentProcessing |
| 1 | TASK-75.1 | 학습: SQS 표준 큐 vs FIFO 큐의 전달 보장 차이 |
| 1 | TASK-75.2 | 실습: `specs/event-driven-microservices/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-76 | TLA+ 명세: pub-sub-fanout — SNS 팬아웃과 EventuallyAllReceive 활성 속성 |
| 1 | TASK-76.1 | 학습: 약한 공정성(WF)이 없으면 활성 속성이 왜 깨지는가 |
| 1 | TASK-76.2 | 실습: `specs/pub-sub-fanout/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-77 | TLA+ 명세: scheduled-batch-jobs — 동시 실행 방지와 NoOverlappingRuns |
| 1 | TASK-77.1 | 학습: EventBridge Scheduler의 FlexibleTimeWindow |
| 1 | TASK-77.2 | 실습: `specs/scheduled-batch-jobs/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-78 | TLA+ 명세: ml-training-pipeline — SageMaker 학습 작업 최종 상태 안정성 (공허한 속성 버그를 발견함) |
| 1 | TASK-78.1 | 학습: TLA+ 시제 연산자 [](Box)와 <>(Diamond) |
| 1 | TASK-78.2 | 실습: `specs/ml-training-pipeline/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-79 | TLA+ 명세: ml-realtime-inference — blue/green 무중단 갱신과 NeverZeroCapacity |
| 1 | TASK-79.1 | 학습: SageMaker 엔드포인트의 블루/그린 업데이트 정책 |
| 1 | TASK-79.2 | 실습: `specs/ml-realtime-inference/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-80 | TLA+ 명세: llm-rag-service — RAG 검색-생성 순서와 NoGenerationWithoutRetrieval |
| 1 | TASK-80.1 | 학습: RAG(Retrieval-Augmented Generation) 패턴과 grounding |
| 1 | TASK-80.2 | 실습: `specs/llm-rag-service/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-81 | TLA+ 명세: multi-account-landing-zone — 계정 생성과 가드레일 원자성 |
| 1 | TASK-81.1 | 학습: AWS Control Tower의 Account Factory와 가드레일 |
| 1 | TASK-81.2 | 실습: `specs/multi-account-landing-zone/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-82 | TLA+ 명세: private-vpc-only — 인터넷 경로 부재(NoInternetRoute) 불변식 |
| 1 | TASK-82.1 | 학습: VPC 라우팅 테이블과 PrivateLink |
| 1 | TASK-82.2 | 실습: `specs/private-vpc-only/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-83 | TLA+ 명세: zero-trust-edge — WAF 우회 방지와 NoBypassingWAF |
| 1 | TASK-83.1 | 학습: AWS WAF Web ACL의 규칙 평가 순서 |
| 1 | TASK-83.2 | 실습: `specs/zero-trust-edge/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-84 | TLA+ 명세: multi-region-active-active — 비동기 복제와 EventuallyFullyReplicated |
| 1 | TASK-84.1 | 학습: leads-to(~>) 연산자와 최종적 일관성(eventual consistency) |
| 1 | TASK-84.2 | 실습: `specs/multi-region-active-active/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-85 | TLA+ 명세: disaster-recovery-pilot-light — 페일오버 3단계 순서와 NoTrafficBeforeReady |
| 1 | TASK-85.1 | 학습: Pilot Light DR 패턴과 RTO/RPO |
| 1 | TASK-85.2 | 실습: `specs/disaster-recovery-pilot-light/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-86 | TLA+ 명세: backup-restore-baseline — 만료 백업 복원 방지(NoRestoreFromExpired) |
| 1 | TASK-86.1 | 학습: AWS Backup의 보존 기간(retention)과 볼트 잠금(Vault Lock) |
| 1 | TASK-86.2 | 실습: `specs/backup-restore-baseline/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-87 | TLA+ 명세: eks-multi-tenant-cluster — 네임스페이스 쿼터와 NoNamespaceExceedsQuota |
| 1 | TASK-87.1 | 학습: TLA+ 함수 업데이트 [f EXCEPT ![x] = ...] 문법 |
| 1 | TASK-87.2 | 실습: `specs/eks-multi-tenant-cluster/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-88 | TLA+ 명세: ecs-fargate-microservices — 롤링 업데이트와 MinHealthyMaintained |
| 1 | TASK-88.1 | 학습: ECS 배포 구성의 minimumHealthyPercent/maximumPercent |
| 1 | TASK-88.2 | 실습: `specs/ecs-fargate-microservices/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-89 | TLA+ 명세: blue-green-deployment — 원자적 트래픽 전환(ExactlyOneActive) |
| 1 | TASK-89.1 | 학습: '상태 표현 자체가 증명이 되는' 모델링 기법 |
| 1 | TASK-89.2 | 실습: `specs/blue-green-deployment/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-90 | TLA+ 명세: canary-deployment — 실패 후 승격 금지(NoPromotionAfterFailure) |
| 1 | TASK-90.1 | 학습: ghost(history) 변수로 '과거에 한 번이라도 X였다'를 표현하기 |
| 1 | TASK-90.2 | 실습: `specs/canary-deployment/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-91 | TLA+ 명세: observability-only-baseline — 에러 버짓 소진 알람과 AlwaysBurningEventuallyFires (TLC가 실제로 반례를 찾음) |
| 1 | TASK-91.1 | 학습: 약한 공정성(WF)과 강한 공정성(SF)의 차이, 그리고 진짜 문제는 둘 다 아니었다는 것 |
| 1 | TASK-91.2 | 실습: `specs/observability-only-baseline/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-92 | TLA+ 명세: cost-optimized-spot-fleet — Spot 2분 경고와 NoTerminationWithoutReplacement |
| 1 | TASK-92.1 | 학습: EC2 Spot 인터럽션 알림(2분 경고)의 실제 메커니즘 |
| 1 | TASK-92.2 | 실습: `specs/cost-optimized-spot-fleet/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-93 | TLA+ 명세: high-traffic-spike — Karpenter 오토스케일링과 BoundedNodes |
| 1 | TASK-93.1 | 학습: Karpenter의 노드 프로비저닝/디프로비저닝 결정 로직 |
| 1 | TASK-93.2 | 실습: `specs/high-traffic-spike/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-94 | TLA+ 명세: serverless-api — Lambda 웜/콜드 디스패치와 ConcurrencyRespected (TLC가 실제로 버그를 찾음) |
| 1 | TASK-94.1 | 학습: TLC가 찾아낸 반례를 직접 재현해보기 |
| 1 | TASK-94.2 | 실습: `specs/serverless-api/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-95 | TLA+ 명세: static-site-cdn — CloudFront 캐시 상태 머신과 NoServingInvalidatedAsHit |
| 1 | TASK-95.1 | 학습: CloudFront 무효화(Invalidation)와 캐시 정책 |
| 1 | TASK-95.2 | 실습: `specs/static-site-cdn/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-96 | TLA+ 명세: multi-tenant-saas — 테넌트 격리와 NoCrossTenantAccess |
| 1 | TASK-96.1 | 학습: TLC 설정 파일의 model value란 무엇인가 |
| 1 | TASK-96.2 | 실습: `specs/multi-tenant-saas/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-97 | 동작 명세: acm — 입력/연산/출력 |
| 1 | TASK-97.1 | 실습: `specs/modules/acm/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-98 | 동작 명세: alb — 입력/연산/출력 |
| 1 | TASK-98.1 | 실습: `specs/modules/alb/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-99 | 동작 명세: amazon-mq — 입력/연산/출력 |
| 1 | TASK-99.1 | 실습: `specs/modules/amazon-mq/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-100 | 동작 명세: api-gateway — 입력/연산/출력 |
| 1 | TASK-100.1 | 실습: `specs/modules/api-gateway/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-101 | 동작 명세: athena — 입력/연산/출력 |
| 1 | TASK-101.1 | 실습: `specs/modules/athena/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-102 | 동작 명세: aws-backup — 입력/연산/출력 |
| 1 | TASK-102.1 | 실습: `specs/modules/aws-backup/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-103 | 동작 명세: bedrock-opensearch — 입력/연산/출력 |
| 1 | TASK-103.1 | 실습: `specs/modules/bedrock-opensearch/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-104 | 동작 명세: cloudfront — 입력/연산/출력 |
| 1 | TASK-104.1 | 실습: `specs/modules/cloudfront/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-105 | 동작 명세: codedeploy — 입력/연산/출력 |
| 1 | TASK-105.1 | 실습: `specs/modules/codedeploy/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-106 | 동작 명세: dms — 입력/연산/출력 |
| 1 | TASK-106.1 | 실습: `specs/modules/dms/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-107 | 동작 명세: dynamodb — 입력/연산/출력 |
| 1 | TASK-107.1 | 실습: `specs/modules/dynamodb/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-108 | 동작 명세: ec2 — 입력/연산/출력 |
| 1 | TASK-108.1 | 실습: `specs/modules/ec2/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-109 | 동작 명세: ecr — 입력/연산/출력 |
| 1 | TASK-109.1 | 실습: `specs/modules/ecr/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-110 | 동작 명세: ecs-service — 입력/연산/출력 |
| 1 | TASK-110.1 | 실습: `specs/modules/ecs-service/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-111 | 동작 명세: eks — 입력/연산/출력 |
| 1 | TASK-111.1 | 실습: `specs/modules/eks/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-112 | 동작 명세: elasticache-redis — 입력/연산/출력 |
| 1 | TASK-112.1 | 실습: `specs/modules/elasticache-redis/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-113 | 동작 명세: eventbridge — 입력/연산/출력 |
| 1 | TASK-113.1 | 실습: `specs/modules/eventbridge/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-114 | 동작 명세: glue — 입력/연산/출력 |
| 1 | TASK-114.1 | 실습: `specs/modules/glue/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-115 | 동작 명세: iam — 입력/연산/출력 |
| 1 | TASK-115.1 | 실습: `specs/modules/iam/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-116 | 동작 명세: iam-github-oidc — 입력/연산/출력 |
| 1 | TASK-116.1 | 실습: `specs/modules/iam-github-oidc/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-117 | 동작 명세: kms — 입력/연산/출력 |
| 1 | TASK-117.1 | 실습: `specs/modules/kms/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-118 | 동작 명세: lambda — 입력/연산/출력 |
| 1 | TASK-118.1 | 실습: `specs/modules/lambda/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-119 | 동작 명세: msk-kafka — 입력/연산/출력 |
| 1 | TASK-119.1 | 실습: `specs/modules/msk-kafka/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-120 | 동작 명세: observability — 입력/연산/출력 |
| 1 | TASK-120.1 | 실습: `specs/modules/observability/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-121 | 동작 명세: organizations-landing-zone — 입력/연산/출력 |
| 1 | TASK-121.1 | 실습: `specs/modules/organizations-landing-zone/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-122 | 동작 명세: rds-postgres — 입력/연산/출력 |
| 1 | TASK-122.1 | 실습: `specs/modules/rds-postgres/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-123 | 동작 명세: redshift — 입력/연산/출력 |
| 1 | TASK-123.1 | 실습: `specs/modules/redshift/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-124 | 동작 명세: route53 — 입력/연산/출력 |
| 1 | TASK-124.1 | 실습: `specs/modules/route53/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-125 | 동작 명세: s3-bucket — 입력/연산/출력 |
| 1 | TASK-125.1 | 실습: `specs/modules/s3-bucket/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-126 | 동작 명세: sagemaker — 입력/연산/출력 |
| 1 | TASK-126.1 | 실습: `specs/modules/sagemaker/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-127 | 동작 명세: secrets-manager — 입력/연산/출력 |
| 1 | TASK-127.1 | 실습: `specs/modules/secrets-manager/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-128 | 동작 명세: sns-sqs — 입력/연산/출력 |
| 1 | TASK-128.1 | 실습: `specs/modules/sns-sqs/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-129 | 동작 명세: step-functions — 입력/연산/출력 |
| 1 | TASK-129.1 | 실습: `specs/modules/step-functions/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-130 | 동작 명세: vpc — 입력/연산/출력 |
| 1 | TASK-130.1 | 실습: `specs/modules/vpc/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-131 | 동작 명세: vpc-endpoints — 입력/연산/출력 |
| 1 | TASK-131.1 | 실습: `specs/modules/vpc-endpoints/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-132 | 동작 명세: waf-shield — 입력/연산/출력 |
| 1 | TASK-132.1 | 실습: `specs/modules/waf-shield/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기 |
| 1 | TASK-177 | Provision local AWS access |
| 1 | TASK-177.1 | Install and authenticate AWS CLI |
| 1 | TASK-177.2 | Verify local AWS access works |
| 1 | TASK-178.1 | Set bootstrap/ input values |
| 1 | TASK-178.2 | terraform apply bootstrap/ |
| 1 | TASK-179.1 | Write root module calling iam-github-oidc for the plan role |
| 1 | TASK-179.2 | Decide and scope policy_arns for the plan role |
| 1 | TASK-179.3 | terraform apply the OIDC root module |
| 1 | TASK-180.1 | gh secret set AWS_PLAN_ROLE_ARN |
| 1 | TASK-181.1 | Open a real PR, confirm terraform plan succeeds against real AWS |
| 1 | TASK-191 | Spring Boot 앱 작성 + 로컬 docker-compose 검증 |
| 1 | TASK-191.1 | Spring Boot 프로젝트 스캐폴딩 + Dockerfile |
| 1 | TASK-191.2 | docker-compose로 app+Postgres 로컬 기동 |
| 1 | TASK-191.3 | curl로 로컬 헬스체크 + DB 연동 확인 |
| 1 | TASK-192.1 | scenarios/standard-web을 live/spring-demo로 복사 + 변수 채우기 |
| 1 | TASK-192.2 | 빌드한 이미지를 ECR에 푸시하고 container_image 교체 |
| 1 | TASK-193.1 | live/spring-demo terraform apply |
| 1 | TASK-193.2 | ALB 엔드포인트로 curl 실사용 검증 |
| 1 | TASK-194.1 | live/spring-demo terraform destroy |
| 1 | TASK-194.2 | AWS CLI로 자원이 실제로 삭제됐는지 이중 확인 |
| 1 | TASK-195 | modules/ecs-service: deployment_controller 지원 추가 |
| 1 | TASK-195.1 | deployment_controller 변수/블록 추가 |
| 1 | TASK-195.2 | scenarios/blue-green-deployment에 적용 검증 + README 갱신 |
| 1 | TASK-196 | modules/codedeploy: linear/canary traffic-shift 설정 노출 |
| 1 | TASK-196.1 | deployment_config_name 변수화 |
| 1 | TASK-196.2 | README에 all-at-once/linear/canary 선택 가이드 추가 |
| 1 | TASK-197 | modules/codedeploy: CloudWatch 알람 자동 롤백 |
| 1 | TASK-197.1 | auto_rollback_configuration + alarm_configuration 추가 |
| 1 | TASK-197.2 | 알람 리소스 선언 위치 결정 + live 템플릿에 반영 |
| 1 | TASK-198 | modules/codedeploy: 배포 전/후 검증 훅 |
| 1 | TASK-198.1 | BeforeAllowTraffic/AfterAllowTraffic Lambda 예시 작성 |
| 1 | TASK-198.2 | appspec Hooks 연결 방식 문서화 + 템플릿 추가 |
| 1 | TASK-198.3 | modules/codedeploy, scenarios/blue-green-deployment README 갱신 |
| 1 | TASK-199.1 | enable_codedeploy 변수 추가 + 조건부 리소스 구성 |
| 1 | TASK-199.2 | 3가지 deployment_config_name 값으로 validate/plan 검증 |
| 1 | TASK-200.1 | live/spring-demo-bluegreen apply + curl로 무중단 전환 확인 |
| 1 | TASK-200.2 | 의도적 실패 이미지로 auto-rollback 실제 발동 확인 |
| 1 | TASK-200.3 | live/spring-demo-bluegreen destroy + AWS CLI 이중 확인 |
| 1 | TASK-201.1 | live/spring-demo-linear apply + 전환 구간 curl 관찰 |
| 1 | TASK-201.2 | 의도적 실패 이미지로 auto-rollback 확인 (linear) |
| 1 | TASK-201.3 | live/spring-demo-linear destroy + AWS CLI 이중 확인 |
| 1 | TASK-202.1 | live/spring-demo-canary apply + 카나리 구간 curl 확인 |
| 1 | TASK-202.2 | 의도적 실패 이미지로 카나리 구간 승격 차단 확인 |
| 1 | TASK-202.3 | live/spring-demo-canary destroy + AWS CLI 이중 확인 |
| 1 | TASK-208 | source-header 적용: freeride/devOps-LifeCycle |
| 2 | TASK-178 | Apply bootstrap/ to create the Terraform state backend |
| 2 | TASK-199 | scenarios/standard-web에 opt-in CodeDeploy 확장 (재사용 템플릿) |
| 3 | TASK-179 | Create the GitHub OIDC plan IAM role |
| 3 | TASK-192 | live/spring-demo 스캐폴딩 + ECR 이미지 푸시 |
| 4 | TASK-180 | Register AWS_PLAN_ROLE_ARN as a CI secret |
| 4 | TASK-193 | AWS 실배포 및 curl 검증 |
| 5 | TASK-181 | Verify plan works end-to-end through real CI |
| 5 | TASK-194 | 자원 정리(destroy) 확인 |
| 5 | TASK-200 | live/spring-demo-bluegreen: All-at-once 실전 배포 + 롤백 검증 + 파괴 |
| 6 | TASK-201 | live/spring-demo-linear: Linear 실전 배포 + 롤백 검증 + 파괴 |
| 7 | TASK-202 | live/spring-demo-canary: Canary 실전 배포 + 롤백 검증 + 파괴 |
