---
id: TASK-91.2
title: '실습: `specs/observability-only-baseline/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기'
status: To Do
assignee: []
created_date: '2026-08-27 06:44'
updated_date: '2026-08-27 08:59'
labels:
  - spec
  - tla
  - hands-on
dependencies: []
references:
  - specs/observability-only-baseline/spec.tla
parent_task_id: TASK-91
type: task
ordinal: 217000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/observability-only-baseline/spec.tla의 각 액션과 변수 정의를 직접 타이핑(복붙 금지)하면서, 왜 이렇게 정의했는지 학습 주석을 단다.

### 실행 검증 (직접 실행)

```bash
# 최초 1회만: TLA+ 도구 받기 (저장소에 커밋되어 있지 않음)
mkdir -p .tla-tools
curl -L -o .tla-tools/tla2tools.jar \
  https://github.com/tlaplus/tlaplus/releases/latest/download/tla2tools.jar

cd specs/observability-only-baseline
java -jar ../../.tla-tools/tla2tools.jar -config spec.cfg spec.tla
# 'Model checking completed. No error has been found.'가 나와야 정상
```

한 걸음 더 — `Spec == Init /\ [][Next]_vars /\ WF_vars(AlarmFires)`에서 `/\ WF_vars(AlarmFires)`를 지우고 (즉 `Spec == Init /\ [][Next]_vars`만 남기고) TLC를 다시 돌려본다 — burning이 한 번 TRUE가 된 뒤 알람이 한 번도 안 울린 채로 그 상태가 영원히 유지되는(stuttering) 반례가 나오는 걸 확인한 뒤, 다시 원래 Spec 정의(WF_vars 포함)로 복원한다.

한 걸음 더 — `AlwaysBurningEventuallyFires`를 주석에 적힌 첫 번째 시도인 `[]burning => <>(alarmState = "Firing")`로 바꿔서 TLC를 돌려본다 — burning이 Init에서 FALSE로 시작하므로 이 속성은 모든 도달 가능한 behavior에서 공허하게(vacuously) 참이 되어 TLC가 항상 "No error"만 보고한다는 걸 직접 확인한다(즉 아무것도 검증하지 않는 죽은 속성이었다는 뜻). 확인 후 원래의 `(<>[]burning) => (<>(alarmState = "Firing"))`로 복원한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 spec.tla의 각 VARIABLES/액션에 왜 이렇게 정의했는지 설명하는 학습 주석이 있다
- [ ] #2 TLC 실행 결과 'Model checking completed. No error has been found.'를 직접 확인했다
- [ ] #3 TLC가 실제로 찾아냈던 반례를 직접 재현했다
- [ ] #4 '[]burning => <>Firing' 버전이 공허하게 항상 참이 된다는 걸 직접 확인했다
<!-- AC:END -->
