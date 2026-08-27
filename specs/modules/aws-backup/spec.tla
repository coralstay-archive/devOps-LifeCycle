---- MODULE spec ----
(*
학습 목적: 이 모듈의 핵심 동작은 백업 계획의 보존 기간(retention_days)이
실제로 vault/plan 설정에 그대로 반영되는지다 — 여기 값이 잘못 전달되면
"백업은 되고 있다고 생각했는데 필요할 때 보니 이미 삭제되어 있었다"는,
백업 시스템에서 가장 뒤늦게 발견되는 실패로 이어진다.

참고 문서:
- AWS Backup API: CreateBackupVault, CreateBackupPlan
  — modules/aws-backup/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

CONSTANTS
    Name,           \* STRING
    Schedule,       \* STRING(cron)
    RetentionDays   \* Nat

Input == [
    name             |-> Name,
    schedule         |-> Schedule,
    retention_days   |-> RetentionDays
]

Precondition(input) ==
    /\ input.name \in STRING /\ input.name # ""
    /\ input.schedule \in STRING
    /\ input.retention_days >= 1

\* 1. CreateBackupVault(name)
\* 2. CreateBackupPlan(name, rule: schedule, lifecycle.delete_after=retention_days)
\* 3. (모듈 범위 밖: resource_arns 각각에 대해 CreateBackupSelection)
Provision(input) ==
    [
        vault_name          |-> input.name \o "-vault",
        plan_id             |-> input.name \o "-plan",
        effective_retention |-> input.retention_days
    ]

\* 이게 이 스펙의 핵심: 실제로 적용된 보존 기간은 입력받은 값과
\* 정확히 같아야 한다 — 여기서 값이 새거나 잘리면 복구 지점이 예상보다
\* 일찍 사라지거나, 불필요하게 오래 남아 비용이 새는 조용한 실패다.
Postcondition(input, output) ==
    /\ output.effective_retention = input.retention_days
    /\ output.vault_name \in STRING

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
