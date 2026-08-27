---- MODULE spec ----
(*
학습 목적: llm-rag-service는 bedrock-opensearch 모듈로 벡터 검색(retrieval)과
LLM 생성(generation)을 엮는다. RAG 패턴의 핵심은 순서다 — 먼저 OpenSearch에서
관련 문서를 검색(Retrieve)하고, 그 결과를 프롬프트에 근거(grounding)로 넣은
뒤에야 Bedrock이 답변을 생성(Generate)한다. 이 순서를 건너뛰면 근거 없는
답변(hallucination 위험 증가)이 나온다 — 그 순서 제약을 여기서 명세한다.

핵심 안전 속성: 검색(retrieved)이 먼저 이뤄지지 않은 채로 답변이 생성되는
경우는 없다 — "검색 없이 바로 생성"하는 경로는 아예 Next에 존재하지 않는다.
*)
EXTENDS Naturals

VARIABLES retrieved, generated

vars == <<retrieved, generated>>

Init ==
    /\ retrieved = FALSE
    /\ generated = FALSE

\* OpenSearch에서 쿼리와 관련된 문서를 벡터 유사도로 검색해온다.
Retrieve ==
    /\ retrieved = FALSE
    /\ retrieved' = TRUE
    /\ UNCHANGED generated

\* 검색된 문서를 컨텍스트로 프롬프트에 넣어 Bedrock 모델이 답변을 생성한다
\* — retrieved가 TRUE일 때만 가능하다는 게 RAG 패턴의 정의 그 자체.
Generate ==
    /\ retrieved = TRUE
    /\ generated = FALSE
    /\ generated' = TRUE
    /\ UNCHANGED retrieved

Next == Retrieve \/ Generate

Spec == Init /\ [][Next]_vars

TypeInvariant ==
    /\ retrieved \in BOOLEAN
    /\ generated \in BOOLEAN

\* 이게 이 스펙의 핵심: 답변이 생성됐다면 반드시 그 전에 검색이 있었다 —
\* RAG가 "검색 증강(retrieval-augmented)"이라는 이름값을 하는지 검증.
NoGenerationWithoutRetrieval == generated => retrieved

====
