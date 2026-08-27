---- MODULE spec ----
(*
학습 목적: data-lake 시나리오는 S3(raw storage) + Glue Crawler(스키마 추론/
카탈로그 등록) + Athena(쿼리)를 엮는다. Terraform은 크롤러를 "만들라"고만
하지, 크롤러가 끝나기 전에 Athena가 그 데이터를 쿼리하면 안 된다는 순서
제약은 표현하지 못한다 — 그 상태 전이를 여기서 명세한다.

핵심 안전 속성: 카탈로그에 등록(Cataloged)되지 않은 데이터는 절대
쿼리(Queried)될 수 없다 — 크롤러가 아직 스키마를 만들지 않은 raw 데이터를
Athena가 읽으려 하면 테이블이 없어 실패해야 정상이라는, 파이프라인 순서
의존성을 모델링한 것.
*)
EXTENDS Naturals

VARIABLES state, queriedWithoutCatalog

vars == <<state, queriedWithoutCatalog>>

States == {"Raw", "Crawling", "Cataloged", "Queried"}

Init ==
    /\ state = "Raw"
    /\ queriedWithoutCatalog = FALSE

\* Glue Crawler가 스키마를 추론하는 중 — 아직 카탈로그에는 반영 안 됨.
StartCrawl ==
    /\ state = "Raw"
    /\ state' = "Crawling"
    /\ UNCHANGED queriedWithoutCatalog

\* 크롤러 완료 — Glue Data Catalog에 테이블 메타데이터가 등록된다.
FinishCrawl ==
    /\ state = "Crawling"
    /\ state' = "Cataloged"
    /\ UNCHANGED queriedWithoutCatalog

\* 카탈로그가 준비된 뒤에만 Athena가 정상적으로 쿼리할 수 있다.
QueryViaAthena ==
    /\ state = "Cataloged"
    /\ state' = "Queried"
    /\ UNCHANGED queriedWithoutCatalog

\* 의도적으로 Next에 포함하지 않은 "버그" 액션 — 카탈로그 없이(Raw/Crawling
\* 상태에서) Athena 쿼리를 시도하는 잘못된 순서. 이런 경로가 실수로 열리면
\* 아래 불변식이 잡아낸다.
\* QueryBeforeCatalog ==
\*     /\ state \in {"Raw", "Crawling"}
\*     /\ queriedWithoutCatalog' = TRUE
\*     /\ UNCHANGED state

Next == StartCrawl \/ FinishCrawl \/ QueryViaAthena

Spec == Init /\ [][Next]_vars

TypeInvariant == state \in States

NoQueryBeforeCatalog == queriedWithoutCatalog = FALSE

====
