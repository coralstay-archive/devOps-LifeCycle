---- MODULE spec ----
(*
학습 목적: multi-tenant-saas 시나리오의 진짜 요구사항은 인프라(EKS/RDS)가
아니라 "테넌트 A가 테넌트 B의 데이터를 절대 못 본다"는 격리 보장이다. 이건
Terraform으로 표현할 수 없는 애플리케이션 레벨 속성이지만, TLA+로는 정확히
표현하고 검증할 수 있다 — 이게 이 시나리오에 TLA+를 쓰는 가장 직접적인
이유다.

핵심 안전 속성: 어떤 Read 액션도 요청한 테넌트가 아닌 다른 테넌트의 데이터를
반환하지 않는다.
*)
EXTENDS Naturals

CONSTANTS Tenants

VARIABLES lastReadTenant, lastReadData, crossTenantLeak

vars == <<lastReadTenant, lastReadData, crossTenantLeak>>

\* tenantData[t]는 테넌트 t 소유의 데이터를 나타내는 단순한 값(테넌트
\* 식별자 자체를 데이터로 씀 — "누구 데이터가 나왔는지"만 검증하면 되므로).
tenantData == [t \in Tenants |-> t]

Init ==
    /\ lastReadTenant \in Tenants
    /\ lastReadData = tenantData[lastReadTenant]
    /\ crossTenantLeak = FALSE

\* 올바른 구현: 요청한 테넌트 자신의 데이터만 반환한다.
ReadOwnData(t) ==
    /\ lastReadTenant' = t
    /\ lastReadData' = tenantData[t]
    /\ UNCHANGED crossTenantLeak

\* 의도적으로 Next에 포함하지 않은 "버그" 액션 — 만약 라우팅/필터링 코드에
\* 실수가 생겨 이 경로가 실제로 열린다면, crossTenantLeak 불변식이 그걸
\* 잡아낸다는 걸 보여주기 위해 정의만 해둔다.
\* ReadOtherTenantData(t, other) ==
\*     /\ other # t
\*     /\ lastReadTenant' = t
\*     /\ lastReadData' = tenantData[other]
\*     /\ crossTenantLeak' = TRUE

Next == \E t \in Tenants : ReadOwnData(t)

Spec == Init /\ [][Next]_vars

TypeInvariant ==
    /\ lastReadTenant \in Tenants
    /\ lastReadData \in Tenants

\* 이게 이 스펙의 핵심: 마지막으로 읽은 데이터는 항상 요청한 테넌트 본인의
\* 것이어야 한다.
NoCrossTenantAccess == lastReadData = lastReadTenant
====
