---- MODULE spec ----
(*
학습 목적: multi-account-landing-zone의 organizations-landing-zone 모듈은
새 AWS 계정을 조직에 추가할 때 SCP(Service Control Policy) 같은 가드레일이
붙은 OU(Organizational Unit)에 배치되도록 만든다. 만약 계정이 가드레일이
붙기 전에 "사용 가능"해지면, 그 짧은 틈에 가드레일 없이 리소스가 만들어질
수 있다 — 그 순서 제약(가드레일이 항상 먼저)을 여기서 명세한다.

핵심 안전 속성: 조직에 합류(Joined)한 계정은 반드시 가드레일이 적용된
상태로만 존재한다 — "가드레일 없는 활성 계정"이라는 상태 자체가 도달
불가능해야 한다.
*)
EXTENDS Naturals

VARIABLES accountState, guardrailsApplied

vars == <<accountState, guardrailsApplied>>

States == {"NotCreated", "Joined"}

Init ==
    /\ accountState = "NotCreated"
    /\ guardrailsApplied = FALSE

\* Landing Zone은 계정을 만들 때 가드레일이 붙은 OU에 배치하는 동작을
\* 원자적으로(atomically) 수행한다 — Control Tower/Organizations의
\* 계정 팩토리(Account Factory)가 실제로 이렇게 동작한다: OU 배치와
\* SCP 적용이 계정 생성 흐름의 일부로 함께 일어난다.
CreateAccountIntoGuardrailedOU ==
    /\ accountState = "NotCreated"
    /\ accountState' = "Joined"
    /\ guardrailsApplied' = TRUE

Next == CreateAccountIntoGuardrailedOU

Spec == Init /\ [][Next]_vars

TypeInvariant ==
    /\ accountState \in States
    /\ guardrailsApplied \in BOOLEAN

\* 이게 이 스펙의 핵심: 계정이 Joined 상태라면 가드레일은 반드시 적용되어
\* 있어야 한다 — "가드레일 없이 먼저 계정만 활성화"하는 경로가 Next에
\* 존재하지 않는다는 것으로 이 속성을 구조적으로 보장한다.
NoAccountWithoutGuardrails == accountState = "Joined" => guardrailsApplied

====
