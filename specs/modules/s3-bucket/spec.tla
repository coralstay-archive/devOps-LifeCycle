---- MODULE spec ----
(*
학습 목적: 이 모듈이 실제로 보장하는 건 뭘까 — variables.tf가 입력, main.tf가
실행하는 AWS API 호출들이 연산, outputs.tf가 출력이라고 보면, s3-bucket의
핵심 동작은 "옵션으로 껐다 켰다 할 수 있는 게 하나도 없이, 암호화와 퍼블릭
액세스 차단은 항상 걸려 있다"는 것이다. 이 방식을 모든 modules/*에 쓰는
이유와, TLC로 검증해도 왜 "증명"이 아니라 "한 예시 확인"인지는
specs/modules/README.md에 한 번만 정리해뒀다 — 이 파일은 그 형태를 실제
TLA+로 어떻게 쓰는지 보여주는 템플릿이다.

참고 문서:
- Amazon S3 API: CreateBucket — https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html
- Amazon S3 API: PutBucketVersioning — https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketVersioning.html
- Amazon S3 API: PutBucketEncryption — https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketEncryption.html
- Amazon S3 API: PutPublicAccessBlock — https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutPublicAccessBlock.html
- Terraform 리소스: modules/s3-bucket/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

\* ---- INPUT ----
\* variables.tf 그대로 — 이게 이 "알고리즘"의 매개변수 목록이다.
CONSTANTS
    BucketName,         \* STRING — 전역적으로 유일한 버킷 이름
    VersioningEnabled,  \* BOOLEAN
    ForceDestroy        \* BOOLEAN

Input == [
    bucket_name         |-> BucketName,
    versioning_enabled  |-> VersioningEnabled,
    force_destroy       |-> ForceDestroy
]

\* 입력이 이 모듈이 가정하는 도메인 안에 있는지 확인하는 사전조건(precondition).
Precondition(input) ==
    /\ input.bucket_name \in STRING
    /\ input.bucket_name # ""
    /\ input.versioning_enabled \in BOOLEAN
    /\ input.force_destroy \in BOOLEAN

\* ---- OPERATION (알고리즘 본문) ----
\* main.tf가 실제로 만드는 4개의 AWS 리소스 = Terraform이 내부적으로
\* 순서대로 호출하는 4개의 S3 API. 이 중 어느 것도 서로 되돌릴 수 있는
\* 순서(reorder-safe)는 아니지만, 서로 독립적인 설정(각기 다른 sub-resource)
\* 이라 순서 자체는 상태 머신이 아니라 "함수형 합성"으로 충분히 표현된다.
\*
\* 1. CreateBucket(bucket_name)                     -> bucket ARN 확보
\* 2. PutBucketVersioning(bucket, versioning_enabled ? "Enabled" : "Suspended")
\* 3. PutBucketEncryption(bucket, "AES256")          -> 이 모듈은 옵션 없이 항상 켠다
\* 4. PutPublicAccessBlock(bucket, block-all=TRUE)   -> 이 모듈은 옵션 없이 항상 켠다
Provision(input) ==
    LET arn == "arn:aws:s3:::" \o input.bucket_name
        versioningState == IF input.versioning_enabled THEN "Enabled" ELSE "Suspended"
    IN [
        bucket_id                   |-> input.bucket_name,
        bucket_arn                  |-> arn,
        bucket_regional_domain_name |-> input.bucket_name \o ".s3.amazonaws.com",
        versioning_state            |-> versioningState,
        \* main.tf에는 이 값을 끌 수 있는 변수가 아예 없다 — 항상 SSE-S3.
        encryption_algorithm        |-> "AES256",
        \* 마찬가지로 항상 4개 전부 TRUE — s3_public_access.rego Conftest
        \* 정책이 검사하는 바로 그 리소스.
        public_access_fully_blocked |-> TRUE
    ]

\* ---- OUTPUT ----
\* outputs.tf + 이 모듈이 실제로 항상 보장해야 하는 후행조건(postcondition).
Postcondition(input, output) ==
    /\ output.bucket_arn = ("arn:aws:s3:::" \o input.bucket_name)
    /\ output.versioning_state \in {"Enabled", "Suspended"}
    /\ (input.versioning_enabled => output.versioning_state = "Enabled")
    \* 이게 이 스펙의 핵심 동작: 옵션으로 켜고 끌 수 있는 게 하나도 없이,
    \* 암호화와 퍼블릭 액세스 차단은 무조건 걸려있어야 한다.
    /\ output.encryption_algorithm = "AES256"
    /\ output.public_access_fully_blocked = TRUE

\* ---- 동작을 TLC로 "실행" ----
\* 상태가 바뀌는 시스템이 아니므로 진짜 VARIABLES는 없다 — TLC가 뭔가를
\* 검사하려면 최소 하나의 상태와 Spec 정의가 필요하므로, 값이 절대 안
\* 바뀌는 더미 변수 하나로 "1개 상태짜리" 모델을 만든다.
VARIABLES dummy

vars == <<dummy>>

Init == dummy = TRUE

Next == UNCHANGED dummy

Spec == Init /\ [][Next]_vars

\* spec.cfg가 CONSTANTS에 넣어준 구체적인 입력 하나에 대해서, Precondition을
\* 만족하는 입력이라면 Provision의 결과가 항상 Postcondition을 만족하는지
\* 확인한다 — "이 하나의 예시에 대해 동작이 실제로 성립하는가"라는, 모든
\* 입력에 대한 증명과는 다른(더 약한) 종류의 검증이라는 걸 위 학습 목적에서
\* 이미 짚었다.
BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
