---- MODULE spec ----
(*
학습 목적: num_cache_nodes가 1이면 자동
페일오버는 켤 수 없다(승격할 복제본이 없으므로) — main.tf의
automatic_failover_enabled = var.num_cache_nodes > 1이 바로 그 논리다.
이 분기를 후행조건으로 명시한다.

참고 문서:
- Amazon ElastiCache API: CreateReplicationGroup
  — modules/elasticache-redis/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

CONSTANTS
    Name,            \* STRING
    NumCacheNodes    \* Nat, >= 1

Input == [
    name              |-> Name,
    num_cache_nodes   |-> NumCacheNodes
]

\* main.tf의 lifecycle.precondition과 동일 — 0개 이하는 "캐시 없음"이지
\* 유효한 최소 배포가 아니다.
Precondition(input) ==
    /\ input.name \in STRING /\ input.name # ""
    /\ input.num_cache_nodes >= 1

\* 관리형 리소스 프로비저닝(추상화): 복제 그룹 내부의 프라이머리/레플리카
\* 승격 로직은 AWS가 관리하므로, "이 설정으로 만들어진 복제 그룹이
\* 존재한다"는 결과 + 페일오버 가능 여부만 모델링한다.
Provision(input) ==
    [
        primary_endpoint            |-> input.name \o ".xxxxx.ng.0001.use1.cache.amazonaws.com",
        \* 노드가 1개뿐이면 읽어올 별도의 reader가 없다.
        reader_endpoint             |-> IF input.num_cache_nodes > 1
                                         THEN input.name \o "-ro.xxxxx.ng.0001.use1.cache.amazonaws.com"
                                         ELSE "null",
        automatic_failover_enabled  |-> input.num_cache_nodes > 1,
        encryption_at_rest          |-> TRUE,  \* main.tf에 이걸 끌 변수가 없다 — 항상 켜짐
        encryption_in_transit       |-> TRUE
    ]

\* 이게 이 스펙의 핵심: 자동 페일오버는 복제본이 최소 1개(즉 노드
\* 2개 이상) 있을 때만 켜질 수 있다 — 승격할 대상이 없는데 페일오버가
\* 켜져 있으면 장애 시 아무 일도 안 일어나는 조용한 실패로 이어진다.
Postcondition(input, output) ==
    /\ output.automatic_failover_enabled = (input.num_cache_nodes > 1)
    /\ (input.num_cache_nodes = 1 => output.reader_endpoint = "null")
    /\ (input.num_cache_nodes > 1 => output.reader_endpoint # "null")
    /\ output.encryption_at_rest = TRUE
    /\ output.encryption_in_transit = TRUE

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
