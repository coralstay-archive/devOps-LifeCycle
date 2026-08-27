---- MODULE spec ----
(*
학습 목적: create_zone 플래그가 두 갈래
경로(새 zone 생성 vs 기존 zone 조회)를 만들고, name_servers는 그 중
"새로 만든 경우"에만 의미가 있다(기존 zone은 이미 다른 곳에 NS가
등록되어 있으므로 이 모듈이 다시 알려줄 이유가 없다) — 이 분기를
정확히 표현하는 게 핵심.

참고 문서:
- Amazon Route 53 API: CreateHostedZone, GetHostedZone, ChangeResourceRecordSets
  — modules/route53/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

Null == "null"

CONSTANTS
    DomainName,  \* STRING
    CreateZone   \* BOOLEAN

Input == [
    domain_name  |-> DomainName,
    create_zone  |-> CreateZone
]

Precondition(input) ==
    /\ input.domain_name \in STRING /\ input.domain_name # ""
    /\ input.create_zone \in BOOLEAN

\* 1. create_zone이면: CreateHostedZone(domain_name) -> zone_id, name_servers 확보
\*    아니면: GetHostedZone(domain_name)으로 기존 zone_id만 조회
\* 2. (모듈 범위 밖: records 맵에 따라 ChangeResourceRecordSets 반복 호출)
Provision(input) ==
    LET zoneId == "Z" \o input.domain_name
    IN [
        zone_id       |-> zoneId,
        name_servers  |-> IF input.create_zone THEN "ns1.awsdns.example" ELSE Null
    ]

\* 이게 이 스펙의 핵심: zone_id는 두 경로 모두에서 항상 나와야 하고
\* (레코드를 만들려면 반드시 필요), name_servers는 새로 만든 zone일
\* 때만 나와야 한다 — 기존 zone에 대해 name_servers를 잘못 반환하면
\* 호출자가 등록기관에 엉뚱한 NS를 등록하는 사고로 이어질 수 있다.
Postcondition(input, output) ==
    /\ output.zone_id \in STRING /\ output.zone_id # ""
    /\ (input.create_zone => output.name_servers # Null)
    /\ (~input.create_zone => output.name_servers = Null)

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
