---- MODULE spec ----
(*
학습 목적: main.tf가 이미 강제하는 "organizational_units가 비어있으면 안
된다"는 사전조건(0개면 for_each가 아무것도 안 만드는데, 그건 이 모듈을
호출한 의미가 없다)을 다시 확인하고, 반환되는 ou_ids 맵이 입력받은 OU
이름 전부를 빠짐없이, 그리고 그것만 키로 가져야 한다는 게 핵심 동작.

참고 문서:
- AWS Organizations API: CreateOrganizationalUnit
  — modules/organizations-landing-zone/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

OrganizationalUnits == {"Security", "Workloads"}

Input == [organizational_units |-> OrganizationalUnits]

Precondition(input) ==
    /\ input.organizational_units \subseteq STRING
    /\ input.organizational_units # {}

\* 1. GetOrganization() -> roots[0].id 확보
\* 2. organizational_units 각각에 대해 CreateOrganizationalUnit(name, parent_id=root)
Provision(input) ==
    [ou_names |-> input.organizational_units]

\* 이게 이 스펙의 핵심: 출력에 나타나는 OU 이름 집합은 입력받은 것과
\* 정확히 같아야 한다 — 하나라도 빠지면 그 팀/워크로드는 거버넌스
\* 경계 밖에 남겨진 것이고, 엉뚱한 이름이 추가되면 의도치 않은 OU가
\* 생긴 것이다.
Postcondition(input, output) ==
    output.ou_names = input.organizational_units

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
