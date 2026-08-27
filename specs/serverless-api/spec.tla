---- MODULE spec ----
(*
학습 목적: serverless-api의 lambda 모듈은 "함수를 만들라"고만 선언한다.
실제로 요청이 올 때 웜 인스턴스가 있으면 즉시 처리하고, 없으면 콜드스타트로
새 인스턴스를 띄운 뒤 처리한다는 동작은 코드 어디에도 안 쓰여 있다 — 그
런타임 동작(과 동시성 한도)을 여기서 명세한다.

핵심 안전 속성: 동시에 처리 중인 요청 수(inFlight)가 설정된 동시성 한도를
절대 넘지 않는다 — Lambda의 실제 동시성 제한(reserved/account concurrency)이
보장하는 바를 그대로 모델링한 것.
*)
EXTENDS Naturals

CONSTANTS MaxConcurrency

VARIABLES warmInstances, inFlight

vars == <<warmInstances, inFlight>>

Init ==
    /\ warmInstances = 0
    /\ inFlight = 0

\* 웜 인스턴스가 있으면 콜드스타트 없이 즉시 처리 — 인스턴스는 그대로,
\* inFlight만 늘어난다.
DispatchWarm ==
    /\ warmInstances > 0
    /\ inFlight < MaxConcurrency
    /\ inFlight' = inFlight + 1
    /\ UNCHANGED warmInstances

\* 웜 인스턴스가 없으면 콜드스타트로 새 인스턴스를 만들면서 동시에 처리한다
\* — 이게 실제로 지연시간이 튀는 지점(콜드스타트 레이턴시)이다.
DispatchCold ==
    /\ inFlight < MaxConcurrency
    /\ warmInstances < MaxConcurrency \* Lambda doesn't grow the warm pool past the concurrency ceiling
    /\ inFlight' = inFlight + 1
    /\ warmInstances' = warmInstances + 1

\* 요청 처리가 끝나면 인스턴스는 (당분간) 웜 상태로 재사용 대기한다 —
\* Lambda가 컨테이너를 바로 죽이지 않고 재사용을 시도하는 실제 동작.
Complete ==
    /\ inFlight > 0
    /\ inFlight' = inFlight - 1
    /\ UNCHANGED warmInstances

Next == DispatchWarm \/ DispatchCold \/ Complete

Spec == Init /\ [][Next]_vars

TypeInvariant ==
    /\ warmInstances \in 0..MaxConcurrency
    /\ inFlight \in 0..MaxConcurrency

ConcurrencyRespected == inFlight <= MaxConcurrency
====
