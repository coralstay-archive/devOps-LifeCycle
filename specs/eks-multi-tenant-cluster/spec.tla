---- MODULE spec ----
(*
학습 목적: eks-multi-tenant-cluster는 eks 모듈 위에 네임스페이스별
ResourceQuota를 둬서 여러 팀(테넌트)이 클러스터를 나눠 쓰게 한다.
Terraform/Kubernetes 매니페스트는 "쿼터가 이 값이다"라고 선언할 뿐, 실제로
어떤 네임스페이스도 자신의 쿼터를 넘어서 자원을 점유할 수 없다는 보장은
Kubernetes 스케줄러/어드미션 컨트롤러의 런타임 동작이다 — 그 동작을 여기서
명세한다.

핵심 안전 속성: 어떤 네임스페이스의 자원 사용량(usage)도 자신에게 할당된
쿼터(quota)를 넘지 않는다 — 한 테넌트의 폭주가 다른 테넌트의 자원을
잠식하는 "시끄러운 이웃(noisy neighbor)" 문제를 막는 핵심 보장.
*)
EXTENDS Naturals

CONSTANTS Namespaces, Quota

VARIABLES usage

vars == <<usage>>

Init == usage = [ns \in Namespaces |-> 0]

\* 네임스페이스 ns에서 파드를 하나 더 만들려는 요청 — 어드미션 컨트롤러가
\* 쿼터를 넘는 요청은 거부(reject)하므로, 이 액션 자체가 쿼터 미만일 때만
\* 활성화된다(거부되는 요청은 상태 변화를 만들지 않으므로 모델링 불필요).
CreatePod(ns) ==
    /\ usage[ns] < Quota
    /\ usage' = [usage EXCEPT ![ns] = @ + 1]

\* 파드가 스케일 인/삭제되어 자원을 반환한다.
DeletePod(ns) ==
    /\ usage[ns] > 0
    /\ usage' = [usage EXCEPT ![ns] = @ - 1]

Next == \E ns \in Namespaces : CreatePod(ns) \/ DeletePod(ns)

Spec == Init /\ [][Next]_vars

TypeInvariant == usage \in [Namespaces -> 0..Quota]

\* 이게 이 스펙의 핵심: 모든 네임스페이스는 언제나 자신의 쿼터 이하로만
\* 자원을 쓴다 — ResourceQuota 어드미션 컨트롤러가 실제로 강제하는 바.
NoNamespaceExceedsQuota == \A ns \in Namespaces : usage[ns] <= Quota

====
