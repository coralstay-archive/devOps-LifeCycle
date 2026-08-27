---- MODULE spec ----
(*
학습 목적: 이 모듈은 RAG(검색 증강 생성)
패턴의 "검색" 절반을 구성한다 — OpenSearch Serverless 컬렉션 하나와,
Bedrock이 그 컬렉션을 읽고 쓸 수 있게 하는 IAM 역할 하나. 이 둘이 항상
함께 나와야 한다는 게 동작이다(역할 없이는 Bedrock이 벡터 검색을 절대
수행할 수 없다) — specs/llm-rag-service/spec.tla가 다루는 "검색 없이는
생성 없다"는 런타임 순서와 짝을 이루는, 배포 시점 동작이다.

참고 문서:
- Amazon OpenSearch Serverless API: CreateCollection
  — modules/bedrock-opensearch/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

CONSTANTS Name  \* STRING

Input == [name |-> Name]

Precondition(input) == input.name \in STRING /\ input.name # ""

\* 1. CreateCollection(name, type=VECTORSEARCH)
\* 2. CreateRole(name + "-bedrock-role", trust=bedrock.amazonaws.com,
\*    permissions=aoss:APIAccessAll scoped to collection_arn)
Provision(input) ==
    LET collectionArn == "arn:aws:aoss:region:000000000000:collection/" \o input.name
    IN [
        collection_endpoint  |-> input.name \o ".region.aoss.amazonaws.com",
        collection_arn       |-> collectionArn,
        bedrock_role_arn     |-> "arn:aws:iam::000000000000:role/" \o input.name \o "-bedrock-role"
    ]

\* 이게 이 스펙의 핵심: 컬렉션과 역할은 항상 함께 나와야 한다 — 둘 중
\* 하나라도 없으면 Bedrock Knowledge Base가 이 컬렉션을 절대 쓸 수 없다.
Postcondition(input, output) ==
    /\ output.collection_endpoint \in STRING /\ output.collection_endpoint # ""
    /\ output.bedrock_role_arn \in STRING /\ output.bedrock_role_arn # ""

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
