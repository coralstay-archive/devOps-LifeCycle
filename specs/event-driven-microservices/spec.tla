---- MODULE spec ----
(*
학습 목적: event-driven-microservices는 sns-sqs 모듈로 큐를 만들 뿐이다.
SQS 표준 큐는 "정확히 한 번(exactly-once)"이 아니라 "최소 한 번(at-least-
once)" 전달을 보장한다 — 즉 같은 메시지가 중복으로 Lambda에 전달될 수
있다는 뜻이고, 그래서 컨슈머는 반드시 멱등성(idempotency)을 구현해야 한다.
그 동작을 여기서 명세한다.

핵심 안전 속성: 메시지가 SQS에 의해 중복 전달(Redeliver)되더라도, 멱등성
키(processedIds)로 걸러내기 때문에 실제 처리 횟수(processedCount)는 한
번을 넘지 않는다 — "결제가 중복 청구됐다"류의 버그를 막는, 이벤트 기반
아키텍처에서 가장 중요한 설계 원칙.
*)
EXTENDS Naturals

VARIABLES delivered, alreadyProcessed, processedCount

vars == <<delivered, alreadyProcessed, processedCount>>

Init ==
    /\ delivered = FALSE
    /\ alreadyProcessed = FALSE
    /\ processedCount = 0

\* SQS가 메시지를 처음(또는 visibility timeout 이후 재차) 전달한다 —
\* at-least-once이므로 이미 delivered였어도 다시 delivered될 수 있다.
Deliver ==
    /\ delivered' = TRUE
    /\ UNCHANGED <<alreadyProcessed, processedCount>>

\* 컨슈머(Lambda)가 메시지를 처리하되, 멱등성 키를 먼저 확인해 이미 처리한
\* 적 있으면 아무 것도 하지 않고(no-op), 처음이면 실제 처리 후 키를 기록한다.
Process ==
    /\ delivered = TRUE
    /\ IF alreadyProcessed
       THEN UNCHANGED <<alreadyProcessed, processedCount>>
       ELSE /\ alreadyProcessed' = TRUE
            /\ processedCount' = processedCount + 1
    /\ UNCHANGED delivered

Next == Deliver \/ Process

Spec == Init /\ [][Next]_vars

TypeInvariant ==
    /\ delivered \in BOOLEAN
    /\ alreadyProcessed \in BOOLEAN
    /\ processedCount \in Nat

\* 이게 이 스펙의 핵심: SQS가 몇 번을 재전달하든, 멱등성 체크 덕분에 실제
\* 부작용(예: 결제 처리)은 정확히 한 번만 일어난다.
IdempotentProcessing == processedCount <= 1

====
