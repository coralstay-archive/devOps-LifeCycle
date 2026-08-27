---- MODULE spec ----
(*
학습 목적: 리포지토리 생성 자체는 단순하지만,
lifecycle policy(untagged_image_expiry_days)가 "태그 없는 이미지만" 만료
대상이라는 걸 정확히 표현하는 게 핵심 — 태그된(배포에 실제로 쓰이는)
이미지는 이 정책의 영향을 받지 않는다는 게 이 모듈이 지키는 안전장치다.

참고 문서:
- Amazon ECR API: CreateRepository, PutLifecyclePolicy
  — modules/ecr/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

CONSTANTS
    Name,                        \* STRING
    UntaggedImageExpiryDays      \* Nat

Input == [
    name                          |-> Name,
    untagged_image_expiry_days    |-> UntaggedImageExpiryDays
]

Precondition(input) ==
    /\ input.name \in STRING /\ input.name # ""
    /\ input.untagged_image_expiry_days \in Nat
    /\ input.untagged_image_expiry_days > 0

\* 1. CreateRepository(name)
\* 2. PutLifecyclePolicy(repo, rule: tagStatus=untagged, expiry=N일)
Provision(input) ==
    [
        repository_url  |-> "000000000000.dkr.ecr.region.amazonaws.com/" \o input.name,
        repository_arn  |-> "arn:aws:ecr:region:000000000000:repository/" \o input.name,
        lifecycle_applies_to_tag_status |-> "untagged",  \* main.tf에 이걸 바꿀 변수가 없다 — 항상 untagged만
        lifecycle_expiry_days           |-> input.untagged_image_expiry_days
    ]

\* 이게 이 스펙의 핵심: 자동 만료 정책은 반드시 "untagged" 이미지에만
\* 적용되어야 한다 — 실수로 "tagged"나 전체(all)로 넓어지면 실제 배포에
\* 쓰이는 이미지가 갑자기 삭제되는 심각한 사고로 이어진다.
Postcondition(input, output) ==
    /\ output.lifecycle_applies_to_tag_status = "untagged"
    /\ output.lifecycle_expiry_days = input.untagged_image_expiry_days
    /\ output.repository_url \in STRING

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
