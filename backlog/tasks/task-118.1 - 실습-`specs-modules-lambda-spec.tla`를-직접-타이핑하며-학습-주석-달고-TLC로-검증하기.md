---
id: TASK-118.1
title: '실습: `specs/modules/lambda/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기'
status: To Do
assignee: []
created_date: '2026-08-27 14:27'
labels:
  - spec
  - tla
  - hands-on
dependencies: []
references:
  - specs/modules/lambda/spec.tla
parent_task_id: TASK-118
type: task
ordinal: 266000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/modules/lambda/spec.tla의 각 정의(Input/Precondition/Provision/Postcondition)를 직접 타이핑(복붙 금지)하면서, 왜 이렇게 정의했는지 학습 주석을 단다.

### 실행 검증 (직접 실행)

```bash
# 최초 1회만: TLA+ 도구 받기 (저장소에 커밋되어 있지 않음)
mkdir -p .tla-tools
curl -L -o .tla-tools/tla2tools.jar \
  https://github.com/tlaplus/tlaplus/releases/latest/download/tla2tools.jar

cd specs/modules/lambda
java -jar ../../../.tla-tools/tla2tools.jar -config spec.cfg spec.tla
# 'Model checking completed. No error has been found.'가 나와야 정상
```

한 걸음 더 — Provision 정의 안의 값을 하나 일부러 틀리게 바꿔본다(예: 문자열 리터럴을 다른 값으로). BehaviorHolds 불변식이 깨지는 걸 TLC로 직접 확인한 뒤, 원래대로 복원한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 spec.tla의 각 정의에 왜 이렇게 정의했는지 설명하는 학습 주석이 있다
- [ ] #2 TLC 실행 결과 'Model checking completed. No error has been found.'를 직접 확인했다
- [ ] #3 Provision을 일부러 깨서 BehaviorHolds 위반을 직접 재현했다
<!-- AC:END -->
