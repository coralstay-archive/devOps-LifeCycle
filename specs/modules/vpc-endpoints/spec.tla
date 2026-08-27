---- MODULE spec ----
(*
학습 목적: interface_services 목록으로 넘긴 서비스 각각이 반드시
인터페이스 엔드포인트로 만들어져야 한다는 게 핵심 동작 — 하나라도
빠지면 그 서비스(예: ecr.dkr)로 가는 트래픽이 private-vpc-only
시나리오에서 여전히 인터넷/NAT 경로를 타게 되어, "프라이빗 전용"이라는
전제 자체가 조용히 깨진다. 이건 specs/private-vpc-only/spec.tla가
런타임 관점(인터넷 게이트웨이 경로 부재)에서 다루는 것과 짝을 이루는,
배포 시점 계약이다.

참고 문서:
- Amazon VPC API: CreateVpcEndpoint
  — modules/vpc-endpoints/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

InterfaceServices == <<"ecr.api", "ecr.dkr", "logs">>

Input == [interface_services |-> InterfaceServices]

Precondition(input) == input.interface_services \in Seq(STRING)

\* 1. CreateSecurityGroup(interface_endpoints) — 443 인그레스만 허용
\* 2. interface_services 각각에 대해 CreateVpcEndpoint(type=Interface,
\*    service_name="com.amazonaws.{region}.{service}", subnet_ids, sg)
\* 3. (모듈 범위 밖: S3/DynamoDB Gateway 엔드포인트는 route_table_ids에 연결)
Provision(input) ==
    [
        endpoint_service_names |-> input.interface_services,
        endpoint_count          |-> Len(input.interface_services)
    ]

\* 이게 이 스펙의 핵심: 만들어진 엔드포인트 개수는 요청한 서비스
\* 개수와 정확히 같아야 하고, 서비스 이름 목록도 입력과 정확히
\* 일치해야 한다 — 하나라도 빠지면 그 서비스만 프라이빗 경로를 잃는다.
Postcondition(input, output) ==
    /\ output.endpoint_count = Len(input.interface_services)
    /\ output.endpoint_service_names = input.interface_services

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
