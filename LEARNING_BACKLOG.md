# 학습 백로그 (Learning Backlog)

이 저장소는 실무 배포 이전에 **학습용**으로 만든 것이라, 부품(모듈) → 시나리오 순서로 각각 무엇을 더 공부해야 하는지 정리한다. 각 항목의 "학습 포인트"는 해당 모듈/시나리오 README의 "Not yet included" / "알려진 제약" / "참고자료: TBD"에서 뽑아온 것 — 즉 지금 코드가 의도적으로 안 하고 있는 부분이 곧 다음에 배울 거리다.

**상태 표시**: ⬜ 미착수 / 🔶 일부 학습함 / ✅ 완료 (직접 갱신)

---

## 1. 부품 (Modules) — 36개

### 기반

| | 모듈 | 핵심 개념 | 학습 포인트 |
|---|---|---|---|
| ⬜ | `vpc` | 네트워크 격리 단위 | CIDR 설계, public/private 서브넷 계층, AZ당 NAT 비용/이중화 트레이드오프, VPC 엔드포인트, Flow Logs |
| ⬜ | `s3-bucket` | 객체 스토리지 | 버저닝+수명주기, SSE-S3 vs SSE-KMS, 버킷 정책 vs ACL, 복제, 액세스 로깅 |
| ⬜ | `iam-github-oidc` | CI 자격증명 연합 | OIDC 연합 원리, `sts:AssumeRoleWithWebIdentity`, 신뢰정책의 `sub`/`aud` 조건, plan/apply 역할 분리 이유 |
| ⬜ | `iam` | 범용 IAM 역할 | 신뢰정책(trust policy) vs 권한정책(permission policy) 구분, managed vs inline policy 트레이드오프, 최소권한 원칙 |
| ⬜ | `ec2` | 원시 가상머신 | IMDSv2가 막는 SSRF 공격 경로, SSH 키 대신 SSM Session Manager를 쓰는 이유, 언제 EC2 대신 ECS/EKS를 써야 하는지 |

### 컴퓨트/네트워크

| | 모듈 | 핵심 개념 | 학습 포인트 |
|---|---|---|---|
| ⬜ | `eks` | 관리형 쿠버네티스 | 컨트롤플레인/노드그룹 구조, **Karpenter vs Cluster Autoscaler**, IRSA, 프라이빗 API 엔드포인트 |
| ⬜ | `ecs-service` | 컨테이너 오케스트레이션(AWS 네이티브) | Fargate vs EC2 launch type, 태스크 실행역할 vs 태스크역할 차이, 서비스 오토스케일링, `deployment_controller` |
| ⬜ | `elasticache-redis` | 인메모리 캐시 | 복제그룹 vs Cluster Mode(샤딩), 자동 페일오버, 읽기 리플리카로 스케일링 |
| ⬜ | `msk-kafka` | 이벤트 스트리밍 | 파티션/브로커 설계, 컨슈머 그룹과 오프셋, MSK Serverless vs Provisioned, IAM/SASL 인증 |
| ⬜ | `rds-postgres` | 관계형 DB | Multi-AZ vs 읽기 복제본, RDS의 Secrets Manager 관리형 마스터 비밀번호, 백업 보존 정책 |
| ⬜ | `observability` | 모니터링/알람 | CloudWatch 지표 vs 로그, SLO/에러버짓과 알람 연결, EKS용 Prometheus/Grafana(AMP/AMG) |

### 1순위 — 범용 인프라

| | 모듈 | 핵심 개념 | 학습 포인트 |
|---|---|---|---|
| ⬜ | `alb` | L7 로드밸런서 | 리스너/타겟그룹/헬스체크, HTTP→HTTPS 리다이렉트, 리스너 규칙으로 다중 서비스 라우팅 |
| ⬜ | `acm` | TLS 인증서 | DNS 검증 흐름, 자동 갱신, CloudFront용 인증서는 반드시 us-east-1이어야 하는 이유 |
| ⬜ | `route53` | DNS | 호스팅존 vs 레코드, 라우팅 정책(가중치/레이턴시/페일오버), 헬스체크 |
| ⬜ | `kms` | 암호화 키 관리 | 키 정책 vs IAM 정책, 자동 로테이션, 대칭/비대칭 키, 크로스계정 키 공유 |
| ⬜ | `secrets-manager` | 시크릿 저장 | 로테이션 Lambda 패턴, Parameter Store와의 차이, 버전 관리 |
| ⬜ | `ecr` | 컨테이너 레지스트리 | 이미지 스캔, 태그 불변성, 수명주기 정책, 크로스계정 풀 권한 |

### 2순위 — 서버리스

| | 모듈 | 핵심 개념 | 학습 포인트 |
|---|---|---|---|
| ⬜ | `lambda` | 함수형 컴퓨트 | 콜드스타트, VPC 연결 시 ENI 지연, 프로비저닝된 동시성, 레이어 |
| ⬜ | `dynamodb` | 서버리스 NoSQL | 파티션 키 설계, GSI/LSI, on-demand vs provisioned, 스트림 |
| ⬜ | `api-gateway` | API 프론트엔드 | REST API vs HTTP API 차이, 프록시 통합, 스로틀링/사용량 계획 |
| ⬜ | `sns-sqs` | 메시징 기본 단위 | 팬아웃 패턴, DLQ/재시도, FIFO 큐, 가시성 타임아웃 |
| ⬜ | `eventbridge` | 이벤트 라우팅 | 이벤트 패턴 매칭, 스케줄 vs 이벤트 기반 트리거, 크로스계정 버스 |
| ⬜ | `cloudfront` | CDN | OAC vs (구)OAI, 캐시 정책/무효화, Lambda@Edge/CloudFront Functions |

### 3순위 — 데이터/분석

| | 모듈 | 핵심 개념 | 학습 포인트 |
|---|---|---|---|
| ⬜ | `glue` | ETL/카탈로그 | 크롤러 vs ETL 잡, 데이터 카탈로그, 파티션 프로젝션 |
| ⬜ | `athena` | 서버리스 쿼리 | 워크그룹별 비용 제어, 파티셔닝으로 스캔량 절감, CTAS |
| ⬜ | `redshift` | 데이터 웨어하우스 | 단일→멀티노드/Serverless 전환 시점, DISTKEY/SORTKEY, Enhanced VPC Routing |
| ⬜ | `dms` | DB 마이그레이션/CDC | full-load vs full-load-and-cdc, 테이블 매핑 규칙, 엔드포인트 인증(Secrets Manager 연동) |
| ⬜ | `step-functions` | 워크플로 오케스트레이션 | Standard vs Express, 상태 종류(Task/Choice/Parallel), 에러 처리/재시도 |

### 4순위 — ML/AI·거버넌스

| | 모듈 | 핵심 개념 | 학습 포인트 |
|---|---|---|---|
| ⬜ | `sagemaker` | ML 추론 | 실시간 vs 배치 추론, 모델/엔드포인트구성/엔드포인트를 분리하는 이유, 오토스케일링 |
| ⬜ | `bedrock-opensearch` | RAG 백엔드 | RAG 흐름(임베딩→검색→생성), 벡터 유사도 검색, OpenSearch Serverless 보안정책 |
| ⬜ | `organizations-landing-zone` | 멀티계정 구조 | OU 설계, SCP, Control Tower와의 관계(이 모듈은 OU만 만듦) |
| ⬜ | `waf-shield` | 엣지 보안 | 매니지드 룰그룹 vs 커스텀 룰, 요율 제한, Shield Standard vs Advanced |
| ⬜ | `aws-backup` | 백업 정책 | 백업 계획/보관정책, 태그기반 vs ARN기반 선택, 크로스리전 복사 |
| ⬜ | `codedeploy` | 배포 오케스트레이션 | 블루/그린 vs 롤링, ECS `deployment_controller` 연동 필요성, 배포 훅 |
| ⬜ | `vpc-endpoints` | 프라이빗 연결 | 게이트웨이 vs 인터페이스 엔드포인트, Private DNS, NAT 대비 비용 |

### 메시징 (틈새)

| | 모듈 | 핵심 개념 | 학습 포인트 |
|---|---|---|---|
| ⬜ | `amazon-mq` | 레거시 브로커 호환 | AMQP/MQTT/STOMP 프로토콜, 액티브/스탠바이 HA, 언제 SNS/SQS 대신 이걸 써야 하는지 |

---

## 2. 시나리오 (Scenarios) — 30개

### 웹/API

| | 시나리오 | 학습 포인트 |
|---|---|---|
| ⬜ | `standard-web` | 3-tier 아키텍처 기본 흐름(ALB→ECS→RDS), 컨테이너 이미지 배포 파이프라인 |
| ⬜ | `high-traffic-spike` | Karpenter의 스파이크 대응 원리, **EKS 노드 보안그룹이 아직 안 뚫려있는 문제(알려진 제약) 직접 고쳐보기** |
| ⬜ | `serverless-api` | Lambda 콜드스타트가 API 레이턴시에 미치는 영향, DynamoDB 접근 패턴 설계 |
| ⬜ | `static-site-cdn` | OAC+버킷정책 조합 원리, 커스텀 도메인 확장(route53+acm 직접 추가해보기) |
| ⬜ | `multi-tenant-saas` | 네임스페이스/RBAC 격리 전략(K8s 레이어, 이 시나리오엔 없음) |

### 데이터/스트리밍

| | 시나리오 | 학습 포인트 |
|---|---|---|
| ⬜ | `real-time-streaming` | 컨슈머 그룹 확장과 파티션 재조정(rebalancing) |
| ⬜ | `data-lake` | 크롤러 스케줄링, 파티션 설계가 쿼리 비용에 미치는 영향 |
| ⬜ | `data-warehouse` | 단일→멀티노드 전환 판단 기준, 분산키(DISTKEY) 설계 |
| ⬜ | `cdc-pipeline` | CDC 원리, **DMS 전용 읽기계정을 마스터 계정과 분리한 설계 이유** 이해하기 |
| ⬜ | `etl-batch` | Step Functions로 Glue 크롤러를 실제로 오케스트레이션하는 법(지금은 placeholder) |

### 캐싱/성능

| | 시나리오 | 학습 포인트 |
|---|---|---|
| ⬜ | `read-heavy-caching` | 캐시 무효화 전략, 읽기 리플리카로 트래픽 분산하는 법 |
| ⬜ | `session-store` | 세션 TTL 설계, Redis 장애 시 세션 유실 대응 방안 |

### 이벤트/메시징

| | 시나리오 | 학습 포인트 |
|---|---|---|
| ⬜ | `event-driven-microservices` | SQS 이벤트소스매핑 배치 크기 튜닝, 멱등성(idempotency) 처리 |
| ⬜ | `pub-sub-fanout` | 팬아웃 패턴 vs 개별 발행 비교, SNS 메시지 필터 정책 |
| ⬜ | `scheduled-batch-jobs` | Lambda 15분 실행 제한 vs ECS/Batch로 전환해야 하는 기준 |

### ML/AI

| | 시나리오 | 학습 포인트 |
|---|---|---|
| ⬜ | `ml-training-pipeline` | 학습 파이프라인이 왜 지속적 Terraform 리소스가 아닌지, SDK/Step Functions 오케스트레이션 |
| ⬜ | `ml-realtime-inference` | 엔드포인트 오토스케일링, 모델 버전 관리 |
| ⬜ | `llm-rag-service` | RAG 전체 흐름, Bedrock Knowledge Base 연동(아직 미포함 — 직접 추가해보기) |

### 네트워크/보안

| | 시나리오 | 학습 포인트 |
|---|---|---|
| ⬜ | `multi-account-landing-zone` | 관리계정 권한 모델, SCP 설계, Control Tower와의 관계 |
| ⬜ | `private-vpc-only` | NAT 없이 아웃바운드하는 경로, 게이트웨이 vs 인터페이스 엔드포인트 선택 기준 |
| ⬜ | `zero-trust-edge` | WAF 매니지드 룰 vs 커스텀 룰, Shield Advanced 비용 판단 기준 |

### 가용성/재해복구

| | 시나리오 | 학습 포인트 |
|---|---|---|
| ⬜ | `multi-region-active-active` | Terraform provider alias 패턴, Route53 라우팅 정책으로 실제 트래픽 분산 구현(아직 미포함) |
| ⬜ | `disaster-recovery-pilot-light` | RTO/RPO 개념, 파일럿라이트 vs 웜스탠바이 vs 멀티사이트 비교 |
| ⬜ | `backup-restore-baseline` | 백업(데이터 보존)과 DR(서비스 연속성)의 목적 차이, 복구 리허설의 중요성 |

### 컨테이너/배포전략

| | 시나리오 | 학습 포인트 |
|---|---|---|
| ⬜ | `eks-multi-tenant-cluster` | 네임스페이스 쿼터/네트워크폴리시(K8s 레이어, 아직 미포함) |
| ⬜ | `ecs-fargate-microservices` | 서비스당 ALB 각각 vs 리스너 규칙 공유의 비용/복잡도 트레이드오프 |
| ⬜ | `blue-green-deployment` | **`deployment_controller = CODE_DEPLOY`가 왜 필요한지(알려진 제약) 직접 고쳐보기**, 트래픽 전환 검증 훅 |
| ⬜ | `canary-deployment` | Argo Rollouts/App Mesh 개념(아직 미포함), 카나리와 블루/그린의 차이 |

### 운영/비용

| | 시나리오 | 학습 포인트 |
|---|---|---|
| ⬜ | `observability-only-baseline` | SLO 대시보드/알람 토픽을 다른 실제 스택에 연결하는 법 |
| ⬜ | `cost-optimized-spot-fleet` | Fargate Spot/EC2 Spot 중단 처리, `capacity_provider_strategy` 직접 추가해보기(아직 미포함) |

---

## 사용 팁

- 순서대로 다 할 필요 없음 — 관심 가는 부품/시나리오부터. 다만 **부품을 먼저 이해한 뒤 그 부품을 쓰는 시나리오로 넘어가는 순서**를 권장 (예: `msk-kafka` 학습 → `real-time-streaming`/`cdc-pipeline` 학습).
- 학습하면서 실제로 코드를 고쳐보고 싶으면, 해당 모듈/시나리오의 "Not yet included"/"알려진 제약"을 직접 구현해보는 게 가장 좋은 연습이다 — 이미 갭이 다 문서화돼 있다.
- 이 문서 자체도 갱신 대상이다: 학습 포인트를 실제로 파고들어 보면서 새로 알게 된 것/틀린 것을 자유롭게 고칠 것.
