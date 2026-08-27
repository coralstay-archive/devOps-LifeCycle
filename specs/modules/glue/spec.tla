---- MODULE spec ----
(*
학습 목적: crawler_schedule이 null이면
수동 실행(on-demand)만 가능하고, 값이 있으면 그 cron으로 자동 실행된다 —
이 분기가 정확히 반영되는지가 핵심.

참고 문서:
- AWS Glue API: CreateDatabase, CreateCrawler
  — modules/glue/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

Null == "null"

CONSTANTS
    DatabaseName,    \* STRING
    S3TargetPath,    \* STRING
    CrawlerSchedule  \* STRING(cron) 또는 Null

Input == [
    database_name     |-> DatabaseName,
    s3_target_path    |-> S3TargetPath,
    crawler_schedule  |-> CrawlerSchedule
]

Precondition(input) ==
    /\ input.database_name \in STRING /\ input.database_name # ""
    /\ input.s3_target_path \in STRING /\ input.s3_target_path # ""
    /\ input.crawler_schedule \in STRING

\* 1. CreateDatabase(database_name)
\* 2. CreateCrawler(database_name, s3_target_path, schedule=crawler_schedule)
Provision(input) ==
    [
        database_name  |-> input.database_name,
        crawler_name    |-> input.database_name \o "-crawler",
        is_scheduled    |-> input.crawler_schedule # Null
    ]

\* 이게 이 스펙의 핵심: is_scheduled는 정확히 crawler_schedule을 줬는지와
\* 일치해야 한다 — 스케줄을 안 줬는데 자동 실행되면 예상치 못한 크롤링
\* 비용/API 호출이 발생하고, 줬는데 자동 실행이 안 되면 data-lake
\* 시나리오처럼 "카탈로그가 최신이라고 가정하는" 다운스트림이 stale
\* 데이터를 보게 된다.
Postcondition(input, output) ==
    /\ output.is_scheduled = (input.crawler_schedule # Null)
    /\ output.crawler_name \in STRING

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
