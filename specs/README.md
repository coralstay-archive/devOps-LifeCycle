# `specs/` — TLA+ formal specifications (scenario runtime behavior)

이 디렉토리는 `scenarios/`의 각 시나리오가 배포된 뒤 **런타임에** 어떻게 동작하는지를
TLA+로 명세하고, TLC 모델 체커로 검증한 결과다.

- Terraform `precondition`/`postcondition`(모듈 스코프)은 "이 리소스 조합이 배포
  시점에 유효한가"를 잡는다.
- 여기 `specs/`(시나리오 스코프)는 "배포된 시스템이 시간에 따라 어떤 상태를 거치며,
  그 과정에서 어떤 안전/활성 속성이 항상 성립해야 하는가"를 잡는다.

왜 이렇게 스코프를 나눴는지는 [`backlog/decisions/decision-2`](../backlog/decisions/decision-2%20-%20모듈-불변식-표현에-TLA-대신-Terraform-precondition-postcondition-사용.md)와
[`decision-3`](../backlog/decisions/decision-3%20-%20시나리오-레벨-런타임-동작-명세에-TLA-채택.md)에 정리되어 있다.

## 구조

```
specs/<scenario-slug>/
├── spec.tla   # 모듈 이름은 반드시 파일명(spec)과 일치해야 한다 — ---- MODULE spec ----
└── spec.cfg   # TLC 실행 설정: SPECIFICATION, CONSTANTS, INVARIANT/PROPERTY, CHECK_DEADLOCK
```

## 도구 설치 (한 번만)

`tla2tools.jar`는 저장소에 커밋하지 않는다(2MB+ 바이너리를 git에 올리지 않는다는
저장소 방침 — `.gitignore`의 `.tla-tools/` 참고). 아래 명령으로 직접 받는다:

```bash
mkdir -p .tla-tools
curl -L -o .tla-tools/tla2tools.jar \
  https://github.com/tlaplus/tlaplus/releases/latest/download/tla2tools.jar
```

Java(11+)만 있으면 별도 설치 없이 이 jar 하나로 파서(SANY)와 모델 체커(TLC)를
모두 쓸 수 있다.

## 스펙 실행 (TLC로 모델 체킹)

```bash
cd specs/<scenario-slug>
java -jar ../../.tla-tools/tla2tools.jar -config spec.cfg spec.tla
```

`Model checking completed. No error has been found.`이 나오면 그 스펙에 정의된
모든 불변식(INVARIANT)/속성(PROPERTY)이 TLC가 탐색한 전체 상태 공간에서 성립한다는
뜻 — **이지만, "No error"만 보고 안심하면 안 된다는 것도 이 저장소가 직접 겪은
교훈이다.** TLC가 실제로 반례를 찾아낸 사례는 `serverless-api`(동시성 한도를 넘는
`warmInstances` 버그)와 `observability-only-baseline`(naive한 활성 속성이 두 번
연속으로 틀렸던 사례 — 처음엔 flapping을 못 잡았고, 고친 버전은 공허하게 항상
참이 되는 죽은 속성이었다)다. 그리고 `ml-training-pipeline`은 "No error"가
**공허한(vacuous) 속성** 때문에 나온 거짓 안심이었던 세 번째 사례다 —
`(state = "Completed") => [](state = "Completed")`처럼 바깥쪽 `[]` 없이 쓴
안정성(stability) 속성은, Init에서 state가 항상 "Completed"가 아닌 값으로
시작하는 한 t=0에서 이미 거짓이라 전체 behavior에서 공허하게 항상 참이 되어버린다
— `Completed → InProgress`로 되돌아가는 명백한 버그를 넣어도 TLC가 "No error"라고
답한다는 걸 이 저장소에서 실제로 확인했고, 올바른 관용구인
`[](state = "Completed" => [](state = "Completed"))`(바깥에 `[]`를 한 번 더
씌워 behavior의 매 시점마다 검사)로 고쳐서야 실제로 검증되는 속성이 됐다. 세
스토리(`backlog task list -m "Formal Specifications (TLA+)"`에서 확인 가능)
설명에 그 과정이 전부 남아있다 — TLA+의 진짜 함정은 "TLC를 돌렸다"가 아니라
"그 속성이 애초에 뭔가를 검증하고 있었는가"라는 것.

## 학습 백로그

이 30개 스펙을 만드는 과정 자체가 학습 프로젝트다. 지금 이 저장소에 있는 30개
스펙은 이미 완성되어 검증까지 끝난 "정답"이지만, 학습 백로그의 각 스토리/태스크는
**전부 `To Do` 상태로 남아있다** — 직접 타이핑하고, 도구를 돌리고, 공식문서를
찾아보는 과정 자체가 학습이라는 이 저장소의 원칙 때문이다. `backlog.md` CLI의
**Formal Specifications (TLA+)**(m-16) 마일스톤 아래 시나리오당:

- 스토리 태스크 — 무엇을 모델링했고 어떤 속성이 왜 중요한지 개념적으로 이해했는지 확인하는 체크리스트
- 실습 자식 태스크 — `spec.tla`를 직접 타이핑하고 TLC를 실행해 검증하는 태스크. TLC가 저작 중 실제로 뭔가를 잡아낸 스펙(`serverless-api`, `observability-only-baseline`, `multi-tenant-saas`)이나 일부러 주석 처리해둔 "버그" 액션이 있는 스펙은 그 반례를 직접 재현해보는 단계까지 포함
- 학습 자식 태스크 — 공식 문서를 찾아 더 깊이 파고들 구체적인 질문

이 등록되어 있다:

```bash
backlog task list -m "Formal Specifications (TLA+)"
```
