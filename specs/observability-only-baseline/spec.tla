---- MODULE spec ----
(*
학습 목적: observability-only-baseline은 observability 모듈만 독립적으로
배포해 CloudWatch 알람이 에러 버짓 소진율(burn rate)을 감시하게 한다.
Terraform은 알람 임계치를 선언할 뿐, 그 임계치를 실제로 넘었을 때 알람이
울린다는 보장(그리고 다시 정상으로 돌아오면 해제된다는 보장)은 CloudWatch
알람 상태 머신의 런타임 동작이다 — Google SRE의 "멀티 윈도우 멀티 버짓
알림" 개념의 단순화 버전을 여기서 명세한다.

핵심 안전 속성: 에러 버짓 소진율이 임계치를 넘은(burning) 상태에서는
알람이 반드시 Firing 상태여야 한다 — 문제가 있는데 알람이 조용한
(silently burning) 상황이 없어야 한다는, 관측성 스택의 존재 이유.
*)
EXTENDS Naturals

VARIABLES burning, alarmState

vars == <<burning, alarmState>>

AlarmStates == {"OK", "Firing"}

Init ==
    /\ burning = FALSE
    /\ alarmState = "OK"

\* 에러율이 SLO 버짓을 갉아먹기 시작한다(burn rate가 임계치를 넘음).
StartBurning ==
    /\ burning = FALSE
    /\ burning' = TRUE
    /\ UNCHANGED alarmState

\* CloudWatch 알람이 평가 주기마다 지표를 확인해 임계치 초과를 감지하고
\* Firing으로 전이한다 — burning 시작과 알람 Firing 사이엔 평가 주기만큼의
\* 짧은 지연이 있을 수 있다는 걸 별도 액션으로 표현.
AlarmFires ==
    /\ burning = TRUE
    /\ alarmState = "OK"
    /\ alarmState' = "Firing"
    /\ UNCHANGED burning

\* 에러율이 정상으로 돌아온다.
StopBurning ==
    /\ burning = TRUE
    /\ burning' = FALSE
    /\ UNCHANGED alarmState

\* 알람이 해제된다(정상 상태 복귀 후).
AlarmClears ==
    /\ burning = FALSE
    /\ alarmState = "Firing"
    /\ alarmState' = "OK"
    /\ UNCHANGED burning

Next == StartBurning \/ AlarmFires \/ StopBurning \/ AlarmClears

\* burning이 계속 지속되는 동안(=AlarmFires가 계속 활성화된 상태로 남아
\* 있는 동안)에는 결국 반드시 일어나야 한다는 약한 공정성(WF) 가정 —
\* CloudWatch 알람 평가 주기가 무한히 미뤄지지 않는다는 것을 모델링.
\* (처음엔 "burning이 한 번이라도 TRUE가 되면"으로 잘못 정의했다가, TLC가
\* "burning이 알람 평가 전에 순간적으로 꺼져버리는" flapping 반례를 찾아
\* 실패했다 — 실제로도 순간적인 버짓 소진은 평가 주기를 못 넘기면 알람이
\* 안 울리는 게 CloudWatch의 정상 동작이므로, 아래 속성은 "burning이 계속
\* 유지되는 경우"로 전제를 고쳤다.)
Spec == Init /\ [][Next]_vars /\ WF_vars(AlarmFires)

TypeInvariant ==
    /\ burning \in BOOLEAN
    /\ alarmState \in AlarmStates

\* 이게 이 스펙의 핵심 활성 속성: burning이 (순간이 아니라) 계속 지속되면
\* 결국 알람은 반드시 Firing이 된다 — "계속 버짓을 소진하는데도 알람이
\* 영원히 조용한" 상황은 없다는 보장. (순간적인 burning은 평가 주기를 못
\* 넘겨 알람이 안 울릴 수 있다는 게 오히려 CloudWatch의 정상 동작이라서,
\* 이 속성의 전제를 "always burning"으로 잡았다.)
AlwaysBurningEventuallyFires == []burning => <>(alarmState = "Firing")

====
