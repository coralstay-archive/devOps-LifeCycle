---
id: m-16
title: "Formal Specifications (TLA+)"
---

## Description

각 시나리오의 런타임 동작(동시성, 순서 제약, 안전/활성 속성)을 TLA+로 명세하고 TLC로 검증하는 학습 프로젝트. modules/scenarios의 precondition/postcondition이 '선언 시점의 정적 제약'을 잡는다면, 여기서는 '실행 중 상태 전이'를 잡는다 — decision-2에서 모듈 스코프에는 TLA+를 채택하지 않기로 한 결정을 시나리오 스코프로 한정해 확장한 것.
