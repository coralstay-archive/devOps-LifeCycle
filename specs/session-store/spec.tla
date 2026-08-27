---- MODULE spec ----
(*
학습 목적: session-store 시나리오는 elasticache-redis에 TTL(만료 시간)이
붙은 세션을 저장한다. Terraform은 "TTL을 설정할 수 있는 Redis를 만들라"고만
하지, TTL이 지난 세션은 절대 유효한 것으로 취급되면 안 된다는 보장은
애플리케이션(과 Redis의 만료 동작) 런타임의 몫이다 — 그 동작을 여기서
명세한다.

핵심 안전 속성: 만료(Expired)된 세션은 절대 인증된(Authenticated) 것으로
취급될 수 없다 — 로그아웃/세션 타임아웃 이후에도 요청이 통과되는 보안
버그를 막는 속성.
*)
EXTENDS Naturals

CONSTANTS SessionTTL

VARIABLES age, sessionState

vars == <<age, sessionState>>

States == {"Active", "Expired"}

Init ==
    /\ age = 0
    /\ sessionState = "Active"

\* 시간이 흐른다 — 세션이 아직 살아있는 동안(Active) 시계가 tick한다.
Tick ==
    /\ sessionState = "Active"
    /\ age < SessionTTL
    /\ age' = age + 1
    /\ UNCHANGED sessionState

\* TTL에 도달하면 Redis가 키를 자동으로 만료시킨다(active expiration/lazy
\* expiration 어느 쪽이든 결과는 동일 — 더 이상 조회되지 않음).
Expire ==
    /\ sessionState = "Active"
    /\ age = SessionTTL
    /\ sessionState' = "Expired"
    /\ UNCHANGED age

Next == Tick \/ Expire

Spec == Init /\ [][Next]_vars

TypeInvariant ==
    /\ age \in 0..SessionTTL
    /\ sessionState \in States

\* 이게 이 스펙의 핵심: Expired 상태에서는 세션이 유효(=Active)하다고 절대
\* 볼 수 없다 — 단순히 상태값 자체가 이 속성을 직접 표현한다(TTL을 넘긴
\* 세션이 다시 Active로 되돌아가는 전이가 Next에 없다는 것이 핵심 보장).
ExpiredIsNeverActive == sessionState = "Expired" => age = SessionTTL

====
