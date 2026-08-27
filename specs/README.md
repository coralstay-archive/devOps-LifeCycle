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
뜻이다. TLC가 실제로 반례를 찾아낸 사례는 `serverless-api`(동시성 한도를 넘는
`warmInstances` 버그)와 `observability-only-baseline`(공정성 가정이 flapping을
못 잡는 문제) — 두 스토리(`backlog task board`에서 확인 가능) 설명에 과정이 남아있다.

## 학습 백로그

이 30개 스펙을 만드는 과정 자체가 학습 프로젝트다. `backlog.md` CLI의
**Formal Specifications (TLA+)**(m-16) 마일스톤 아래 시나리오당 스토리 태스크(무엇을
모델링했고 어떤 속성을 검증했는지) + 학습 자식 태스크(공식 문서를 찾아 더 깊이
파고들 구체적인 질문)가 등록되어 있다:

```bash
backlog task list -m "Formal Specifications (TLA+)"
```
