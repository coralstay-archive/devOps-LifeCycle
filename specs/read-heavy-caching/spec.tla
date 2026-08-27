---- MODULE spec ----
(*
학습 목적: read-heavy-caching은 elasticache-redis 모듈로 캐시 인스턴스를
만들 뿐, "cache-aside" 패턴(먼저 캐시를 보고, 없으면 DB에서 읽어 캐시를
채우고, 쓰기 시엔 캐시를 무효화한다)은 애플리케이션 런타임 동작이다. 이
패턴이 깨지면 캐시가 DB의 최신 값과 다른 stale 데이터를 계속 서빙하게 된다
— 그 동작을 여기서 명세한다.

핵심 안전 속성: DB 값이 갱신(Write)된 뒤에는, 캐시가 다시 채워지기 전까지
캐시된 값을 그대로 반환해서는 안 된다 — 쓰기 시 캐시를 무효화하지 않으면
생기는 전형적인 캐시 일관성 버그를 막는 속성.
*)
EXTENDS Naturals

CONSTANTS MaxValue

VARIABLES dbValue, cacheValue, cacheValid

vars == <<dbValue, cacheValue, cacheValid>>

Init ==
    /\ dbValue = 0
    /\ cacheValue = 0
    /\ cacheValid = FALSE

\* 쓰기: DB 값을 갱신하고, cache-aside 패턴에 따라 캐시를 즉시 무효화한다.
WriteAndInvalidate ==
    /\ dbValue < MaxValue
    /\ dbValue' = dbValue + 1
    /\ cacheValid' = FALSE
    /\ UNCHANGED cacheValue

\* 캐시 미스: 캐시가 무효 상태일 때 DB에서 읽어 캐시를 채운다(populate).
ReadMissPopulatesCache ==
    /\ cacheValid = FALSE
    /\ cacheValue' = dbValue
    /\ cacheValid' = TRUE
    /\ UNCHANGED dbValue

\* 캐시 히트: 캐시가 유효할 때는 DB를 안 보고 캐시 값을 그대로 반환한다
\* (이게 이 패턴이 존재하는 이유 — DB 부하를 줄이는 것).
ReadHitFromCache ==
    /\ cacheValid = TRUE
    /\ UNCHANGED vars

Next == WriteAndInvalidate \/ ReadMissPopulatesCache \/ ReadHitFromCache

Spec == Init /\ [][Next]_vars

TypeInvariant ==
    /\ dbValue \in 0..MaxValue
    /\ cacheValue \in 0..MaxValue
    /\ cacheValid \in BOOLEAN

\* 이게 이 스펙의 핵심: 캐시가 유효하다고 표시되어 있다면, 캐시 값은 반드시
\* 현재 DB 값과 일치해야 한다 — 무효화를 빼먹으면 이 불변식이 깨진다.
NoStaleReadWhenValid == cacheValid => (cacheValue = dbValue)

====
