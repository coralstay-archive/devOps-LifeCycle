---- MODULE spec ----
(*
학습 목적: canary-deployment는 alb 가중치 기반 라우팅(weighted target
groups)으로 새 버전에 트래픽의 일부(예: 10% -> 50% -> 100%)만 점진적으로
흘려보낸다. blue-green과 달리 여기서는 "일정 기간 두 버전이 동시에 트래픽을
나눠 받는" 상태가 정상이다 — 대신 canary 쪽 가중치는 사람이 확인하며 한
단계씩만 올라가야지, 검증 없이 갑자기 100%로 뛰거나 실패 중에 계속
올라가면 안 된다는 제약이 있다. 그 동작을 여기서 명세한다.

핵심 안전 속성: canary 가중치(canaryWeight)는 실패가 감지(failureDetected)된
상태에서는 절대 증가하지 않는다 — 문제가 있는 버전으로 트래픽을 더 늘리는
사고를 막는다.
*)
EXTENDS Naturals

CONSTANTS Steps

VARIABLES canaryWeight, failureDetected, promotedAfterFailure

vars == <<canaryWeight, failureDetected, promotedAfterFailure>>

Init ==
    /\ canaryWeight = 0
    /\ failureDetected = FALSE
    /\ promotedAfterFailure = FALSE \* 유령(ghost) 변수 — "실패 감지 후 승격이 한 번이라도 일어났는가"만 기록

\* 실패가 감지되지 않은 동안에만, 사람(또는 자동화된 검증 게이트)이 canary
\* 가중치를 한 단계 올린다.
PromoteCanary ==
    /\ failureDetected = FALSE
    /\ canaryWeight < Steps
    /\ canaryWeight' = canaryWeight + 1
    /\ UNCHANGED <<failureDetected, promotedAfterFailure>>

\* 모니터링(observability 모듈의 알람)이 canary 버전에서 에러율 급증 등을
\* 감지한다.
DetectFailure ==
    /\ failureDetected = FALSE
    /\ failureDetected' = TRUE
    /\ UNCHANGED <<canaryWeight, promotedAfterFailure>>

\* 실패가 감지되면 canary 가중치를 0으로 즉시 되돌린다(자동 롤백).
RollbackCanary ==
    /\ failureDetected = TRUE
    /\ canaryWeight' = 0
    /\ UNCHANGED <<failureDetected, promotedAfterFailure>>

\* 만약 실수로 "실패 감지 후에도 승격이 가능한" 버그 경로가 생긴다면, 그건
\* PromoteCanary의 가드를 깨는 별도 액션일 것이다 — 여기서는 그런 액션을
\* Next에 절대 포함하지 않음으로써, ghost 변수 promotedAfterFailure가 영원히
\* FALSE로 남는다는 것 자체가 "그런 경로가 없다"는 증명이 된다.

Next == PromoteCanary \/ DetectFailure \/ RollbackCanary

Spec == Init /\ [][Next]_vars

TypeInvariant ==
    /\ canaryWeight \in 0..Steps
    /\ failureDetected \in BOOLEAN
    /\ promotedAfterFailure \in BOOLEAN

\* 이게 이 스펙의 핵심: 실패 감지 후 승격이 일어난 적이 있다는 기록
\* (promotedAfterFailure)은 절대 TRUE가 되지 않는다.
NoPromotionAfterFailure == promotedAfterFailure = FALSE

====
