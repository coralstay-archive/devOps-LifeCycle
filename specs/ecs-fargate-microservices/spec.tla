---- MODULE spec ----
(*
학습 목적: ecs-fargate-microservices의 ecs-service 모듈은
minimum_healthy_percent/maximum_percent를 설정해 롤링 업데이트 중에도
일정 비율 이상의 healthy 태스크가 항상 떠 있게 한다. Terraform은 이 숫자를
선언할 뿐, 배포 중 실제로 그 비율이 지켜진다는 보장은 ECS 배포 컨트롤러의
런타임 동작이다 — 그 동작을 여기서 명세한다.

핵심 안전 속성: 배포 중 어느 순간에도 healthy 태스크 수가
minHealthy(desiredCount 기준 최소치) 아래로 떨어지지 않는다 — 롤링
업데이트가 가용성을 해치지 않는다는 보장.
*)
EXTENDS Naturals

CONSTANTS DesiredCount, MinHealthy

VARIABLES oldHealthy, newHealthy

vars == <<oldHealthy, newHealthy>>

Init ==
    /\ oldHealthy = DesiredCount
    /\ newHealthy = 0

\* 새 태스크 정의 버전의 태스크를 하나 띄운다 — old를 먼저 안 내리고
\* 추가로 띄우는 것부터 시작(maximum_percent > 100%를 모델링).
StartNewTask ==
    /\ oldHealthy + newHealthy < 2 * DesiredCount
    /\ newHealthy' = newHealthy + 1
    /\ UNCHANGED oldHealthy

\* 새 태스크가 충분히 떠서 healthy 하한선을 지킬 수 있을 때만, 이전 버전
\* 태스크를 하나 내린다 — 이 가드가 minimum_healthy_percent의 핵심.
StopOldTask ==
    /\ oldHealthy > 0
    /\ (oldHealthy - 1) + newHealthy >= MinHealthy
    /\ oldHealthy' = oldHealthy - 1
    /\ UNCHANGED newHealthy

Next == StartNewTask \/ StopOldTask

Spec == Init /\ [][Next]_vars

TypeInvariant ==
    /\ oldHealthy \in 0..DesiredCount
    /\ newHealthy \in 0..(2 * DesiredCount)

\* 이게 이 스펙의 핵심: 배포 중 전체 healthy 태스크 수는 항상 최소 허용치
\* 이상으로 유지된다.
MinHealthyMaintained == (oldHealthy + newHealthy) >= MinHealthy

====
