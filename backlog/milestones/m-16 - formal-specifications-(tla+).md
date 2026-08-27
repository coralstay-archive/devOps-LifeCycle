---
id: m-16
title: "Formal Specifications (TLA+)"
---

## Description

TLA+로 두 가지 서로 다른 관점을 명세하고 TLC로 검증하는 학습 프로젝트:

- **시나리오 스코프** (`specs/<scenario>/`): 런타임 동작(동시성, 순서 제약, 안전/활성 속성) — modules/scenarios의 precondition/postcondition이 '선언 시점의 정적 제약'을 잡는다면, 여기서는 '실행 중 상태 전이'를 잡는다.
- **모듈 스코프** (`specs/modules/<module>/`): 각 모듈을 입력(variables.tf) → 연산(main.tf가 호출하는 AWS API 순서) → 출력(outputs.tf + 후행조건)으로 보는 동작 명세. 동시성 상태 머신이 아니라 한 번의 구체적 입력에 대해 후행조건이 성립하는지 TLC로 확인한다.

decision-2가 모듈 스코프에서 거부한 건 "동시성 상태 머신으로서의 TLA+"였다 — 이 둘은 그 결정을 뒤집는 게 아니라, TLA+를 쓰는 두 가지 다른 방식으로 스코프를 넓힌 것이다([[decision-3]], [[decision-4]] 참고).
