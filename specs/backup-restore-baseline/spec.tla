---- MODULE spec ----
(*
학습 목적: backup-restore-baseline의 aws-backup 모듈은 백업 계획(주기, 보존
기간)을 정의한다. 보존 기간(retention)이 지나 백업이 만료(Expired)되면 그
복구 지점(recovery point)은 더 이상 존재하지 않으므로 복원(Restore)할 수
없다 — 당연해 보이지만 실제 장애 대응 중에 "이미 만료된 백업을 복원하려는"
실수가 자주 일어난다. 그 제약을 여기서 명세한다.

핵심 안전 속성: 만료(Expired)된 백업은 절대 복원(Restored)될 수 없다 —
복원은 반드시 아직 유효(Available)한 복구 지점에서만 가능하다.
*)
EXTENDS Naturals

VARIABLES backupState, restoreAttemptedOnExpired

vars == <<backupState, restoreAttemptedOnExpired>>

States == {"Available", "Expired", "Restored"}

Init ==
    /\ backupState = "Available"
    /\ restoreAttemptedOnExpired = FALSE

\* 보존 기간이 지나면 AWS Backup이 복구 지점을 자동으로 삭제(만료)한다.
ExpireBackup ==
    /\ backupState = "Available"
    /\ backupState' = "Expired"
    /\ UNCHANGED restoreAttemptedOnExpired

\* 보존 기간 내에 있을 때만 복원이 성공적으로 이뤄진다.
RestoreFromAvailable ==
    /\ backupState = "Available"
    /\ backupState' = "Restored"
    /\ UNCHANGED restoreAttemptedOnExpired

\* 의도적으로 Next에서 뺀 "버그" 액션 — 이미 만료된 백업을 복원하려는 시도.
\* 실제 AWS Backup API라면 이 시점에 에러를 반환해야 정상이라는 걸 보여주기
\* 위해 정의만 해둔다.
\* RestoreFromExpired ==
\*     /\ backupState = "Expired"
\*     /\ restoreAttemptedOnExpired' = TRUE
\*     /\ UNCHANGED backupState

Next == ExpireBackup \/ RestoreFromAvailable

Spec == Init /\ [][Next]_vars

TypeInvariant ==
    /\ backupState \in States
    /\ restoreAttemptedOnExpired \in BOOLEAN

NoRestoreFromExpired == restoreAttemptedOnExpired = FALSE

====
