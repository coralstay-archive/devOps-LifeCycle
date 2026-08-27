---
id: TASK-94.2
title: '실습: `specs/serverless-api/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기'
status: To Do
assignee: []
created_date: '2026-08-27 06:44'
labels:
  - spec
  - tla
  - hands-on
dependencies: []
references:
  - specs/serverless-api/spec.tla
parent_task_id: TASK-94
type: task
ordinal: 220000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/serverless-api/spec.tla의 각 액션과 변수 정의를 직접 타이핑(복붙 금지)하면서, 왜 이렇게 정의했는지 학습 주석을 단다.

### 실행 검증 (직접 실행)

```bash
# 최초 1회만: TLA+ 도구 받기 (저장소에 커밋되어 있지 않음)
mkdir -p .tla-tools
curl -L -o .tla-tools/tla2tools.jar \
  https://github.com/tlaplus/tlaplus/releases/latest/download/tla2tools.jar

cd specs/serverless-api
java -jar ../../.tla-tools/tla2tools.jar -config spec.cfg spec.tla
# 'Model checking completed. No error has been found.'가 나와야 정상
```

한 걸음 더 — DispatchCold 정의에서 `/\ warmInstances < MaxConcurrency` 줄을 지우고 TLC를 다시 돌려본다 — TypeInvariant 위반 반례가 실제로 나오는 걸 확인하고, 어떤 상태 시퀀스에서 warmInstances가 MaxConcurrency를 넘는지 반례 트레이스를 읽어본 뒤 가드를 원래대로 복원한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 spec.tla의 각 VARIABLES/액션에 왜 이렇게 정의했는지 설명하는 학습 주석이 있다
- [ ] #2 TLC 실행 결과 'Model checking completed. No error has been found.'를 직접 확인했다
- [ ] #3 TLC가 실제로 찾아냈던 반례를 직접 재현했다
<!-- AC:END -->
