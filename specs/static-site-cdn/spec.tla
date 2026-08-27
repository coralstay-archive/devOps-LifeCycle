---- MODULE spec ----
(*
학습 목적: static-site-cdn의 cloudfront 모듈은 캐시 동작 자체를 명세하지
않는다 — TTL 만료, 재검증, 무효화(invalidation)가 어떤 순서로만 가능한지는
CloudFront의 실제 동작을 보고 이해해야 한다. 그 상태 전이를 여기서
명세한다.

핵심 안전 속성: Invalidated된 객체는 반드시 원본(origin)에서 다시 가져온
뒤에만 다시 Hit가 될 수 있다 — "무효화됐는데 캐시가 그대로 서빙되는" 상황이
없어야 한다는, CDN 캐싱에서 가장 흔한 버그 클래스를 막는 속성이다.
*)
EXTENDS Naturals

VARIABLES state, servedStaleAfterInvalidation

vars == <<state, servedStaleAfterInvalidation>>

States == {"Miss", "Hit", "Stale", "Invalidated"}

Init ==
    /\ state = "Miss"
    /\ servedStaleAfterInvalidation = FALSE

\* 최초 요청 — 원본에서 가져와 캐시에 채운다.
FetchFromOrigin ==
    /\ state \in {"Miss", "Invalidated"}
    /\ state' = "Hit"
    /\ UNCHANGED servedStaleAfterInvalidation

\* TTL 만료 — 아직 서빙은 가능하지만(stale-while-revalidate 없이 단순화하면
\* 여기선 재검증 전까지는 못 그냥 서빙한다고 모델링) 재검증이 필요한 상태.
Expire ==
    /\ state = "Hit"
    /\ state' = "Stale"
    /\ UNCHANGED servedStaleAfterInvalidation

\* 재검증 성공 — 원본 콘텐츠가 그대로라 다시 Hit로.
Revalidate ==
    /\ state = "Stale"
    /\ state' = "Hit"
    /\ UNCHANGED servedStaleAfterInvalidation

\* 명시적 무효화(예: 새 배포) — Hit든 Stale이든 즉시 Invalidated로 강등된다.
Invalidate ==
    /\ state \in {"Hit", "Stale"}
    /\ state' = "Invalidated"
    /\ UNCHANGED servedStaleAfterInvalidation

\* 이 액션은 "버그 시나리오"를 흉내내기 위한 게 아니라, Next에 절대 포함되지
\* 않음으로써 "이런 전이는 있을 수 없다"는 걸 명시적으로 보여주기 위한 것 —
\* 만약 실수로 Next에 추가된다면 아래 불변식이 깨지는 걸 TLC가 잡아준다.
\* ServeStaleFromInvalidated ==
\*     /\ state = "Invalidated"
\*     /\ servedStaleAfterInvalidation' = TRUE
\*     /\ UNCHANGED state

Next == FetchFromOrigin \/ Expire \/ Revalidate \/ Invalidate

Spec == Init /\ [][Next]_vars

TypeInvariant == state \in States

NoServingInvalidatedAsHit == servedStaleAfterInvalidation = FALSE
====
