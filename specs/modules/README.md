# `specs/modules/` — module contracts (input → operation → output)

`specs/<scenario>/`가 배포된 시스템이 시간에 따라 어떻게 움직이는지(런타임
상태 머신)를 다뤘다면, 여기 `specs/modules/`는 완전히 다른 관점이다 — 개별
모듈은 동시성도, 여러 상태로의 전이도 없다. 대신 각 모듈을 하나의 함수로 본다:

```
INPUT(입력)      variables.tf의 변수들
OPERATION(연산)  main.tf가 실제로 호출하는 AWS API들의 순서
OUTPUT(출력)     outputs.tf의 값들 + 그 값이 항상 만족해야 하는 후행조건
```

이건 TLA+를 "동시성 검증 도구"가 아니라 "엄밀한 함수 명세 언어"로 쓰는
것이다. TLC로 이 동작을 "실행"하긴 하지만, 이건 어디까지나
`spec.cfg`가 지정한 구체적인 입력값 **하나**에 대해서만 후행조건이 실제로
성립하는지 확인하는 것이다 — 모든 가능한 입력에 대한 증명이 아니라, 동작을
명시적이고 기계로 확인 가능하게 만드는 게 목적이다. 모든 입력에 대한 정적
타입 제약은 여전히 `variables.tf`의 타입 선언과 각 모듈의
`precondition`/`postcondition`([[decision-2]])이 담당한다.

## 예시로 보면: `s3-bucket`

- **입력**: `bucket_name`(STRING), `versioning_enabled`(BOOLEAN), `force_destroy`(BOOLEAN)
- **연산**: `CreateBucket` → `PutBucketVersioning` → `PutBucketEncryption` → `PutPublicAccessBlock` — main.tf가 실제로 만드는 4개 리소스 순서 그대로
- **출력 + 후행조건**: `bucket_arn`은 항상 `arn:aws:s3:::{bucket_name}` 형태여야 하고, 암호화와 퍼블릭 액세스 차단은 `versioning_enabled` 값과 무관하게 **항상** 켜져 있어야 한다 — main.tf에 이 둘을 끌 수 있는 변수 자체가 없기 때문이다.

`specs/modules/s3-bucket/spec.tla`가 이 형태를 실제 TLA+로 어떻게 쓰는지
보여주는 템플릿이다 — 새 모듈 동작을 쓸 때 그 파일 구조(`CONSTANTS` →
`Input` → `Precondition` → `Provision` → `Postcondition` → 1개 상태짜리
더미 `Spec` → `BehaviorHolds`)를 그대로 따라간다.

## 관리형 서비스는 다르게

RDS, EKS, ElastiCache 같은 관리형 서비스는 "이 API를 이 순서로 호출한다"고
알고리즘화하기 어렵다 — AWS가 내부 동작(복제, 페일오버, 노드 배치)을
관리하기 때문이다. 이런 모듈은 OPERATION을 "이 설정으로 관리형 리소스를
프로비저닝한다"는 더 추상화된 동사로 표현하고, 대신 그 모듈이 실제로
강제하는 논리적 제약(예: `eks`의 `min <= desired <= max`, `msk-kafka`의
브로커 수가 AZ 수의 배수)을 후행조건으로 정확히 표현하는 데 집중한다.

## 도구 실행

`specs/README.md`와 동일한 `tla2tools.jar`를 그대로 쓴다:

```bash
cd specs/modules/<module-slug>
java -jar ../../../.tla-tools/tla2tools.jar -config spec.cfg spec.tla
```
