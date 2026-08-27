---- MODULE spec ----
(*
학습 목적: availability_zones가 리스트이고, public/private
서브넷과 라우트 테이블이 "AZ 개수만큼" 만들어진다 — 알고리즘으로 치면
루프(for each AZ) + 배열 인덱싱에 해당한다. TLA+에서는 이런 "AZ별 1개씩"
관계를 시퀀스(Seq)와 그 Len()으로 정확히 표현할 수 있다.

참고 문서:
- Amazon VPC API: CreateVpc, CreateSubnet, CreateNatGateway, CreateRouteTable
  — https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html
- modules/vpc/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

CONSTANTS
    Name,               \* STRING
    CidrBlock,          \* STRING
    EnableNatGateway    \* BOOLEAN

\* Seq 값은 .cfg 파일의 CONSTANT 대입 문법(<<...>>)으로 표현할 수 없어서
\* (TLC .cfg는 모델 값/문자열/숫자/집합만 지원) 여기 직접 정의한다 — 이
\* 하나의 구체적 예시 입력에 대해 동작이 성립하는지 보는 게 목적이므로,
\* CONSTANT로 빼서 .cfg에서 바꿔 끼울 필요가 없다.
AvailabilityZones == <<"ap-northeast-2a", "ap-northeast-2c">>

Input == [
    name                |-> Name,
    cidr_block          |-> CidrBlock,
    availability_zones  |-> AvailabilityZones,
    enable_nat_gateway  |-> EnableNatGateway
]

Precondition(input) ==
    /\ input.name \in STRING
    /\ input.cidr_block \in STRING
    /\ input.availability_zones \in Seq(STRING)
    /\ input.enable_nat_gateway \in BOOLEAN

\* 1. CreateVpc(cidr_block)
\* 2. CreateInternetGateway + 연결
\* 3. AZ마다: CreateSubnet(public), CreateSubnet(private)
\* 4. enable_nat_gateway면 AZ마다: AllocateAddress + CreateNatGateway
\* 5. CreateRouteTable(public) 1개, CreateRouteTable(private) AZ마다 1개씩
\*    (private가 AZ마다 별도인 이유: NAT Gateway가 AZ별로 있어서 라우팅도
\*    AZ별로 분리해야 한 AZ의 NAT 장애가 다른 AZ에 영향을 안 준다)
Provision(input) ==
    LET n == Len(input.availability_zones)
        vpcId == "vpc-" \o input.name
        AzId(prefix, i) == prefix \o "-" \o input.name \o "-" \o input.availability_zones[i]
        publicIds == [i \in 1..n |-> AzId("subnet-pub", i)]
        privateIds == [i \in 1..n |-> AzId("subnet-priv", i)]
        privateRtIds == [i \in 1..n |-> AzId("rtb-priv", i)]
    IN [
        vpc_id                   |-> vpcId,
        public_subnet_ids        |-> publicIds,
        private_subnet_ids       |-> privateIds,
        private_route_table_ids  |-> privateRtIds
    ]

\* 이게 이 스펙의 핵심: outputs.tf에 실제로 있는 precondition — "private
\* 서브넷은 정확히 AZ 개수만큼"이라는 불변식을 output 레코드 전체(서브넷,
\* 라우트 테이블 모두)에 대해 후행조건 형태로 재확인한다.
Postcondition(input, output) ==
    LET n == Len(input.availability_zones) IN
    /\ Len(output.public_subnet_ids) = n
    /\ Len(output.private_subnet_ids) = n
    /\ Len(output.private_route_table_ids) = n

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
