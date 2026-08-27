---
id: TASK-78.2
title: '실습: `specs/ml-training-pipeline/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기'
status: To Do
assignee: []
created_date: '2026-08-27 06:43'
updated_date: '2026-08-27 09:13'
labels:
  - spec
  - tla
  - hands-on
dependencies: []
references:
  - specs/ml-training-pipeline/spec.tla
parent_task_id: TASK-78
type: task
ordinal: 204000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/ml-training-pipeline/spec.tla의 각 액션과 변수 정의를 직접 타이핑(복붙 금지)하면서, 왜 이렇게 정의했는지 학습 주석을 단다.

### 실행 검증 (직접 실행)

```bash
# 최초 1회만: TLA+ 도구 받기 (저장소에 커밋되어 있지 않음)
mkdir -p .tla-tools
curl -L -o .tla-tools/tla2tools.jar \
  https://github.com/tlaplus/tlaplus/releases/latest/download/tla2tools.jar

cd specs/ml-training-pipeline
java -jar ../../.tla-tools/tla2tools.jar -config spec.cfg spec.tla
# 'Model checking completed. No error has been found.'가 나와야 정상
```

한 걸음 더 — 아래 두 가지를 순서대로 해본다:

1. `Next == Complete \/ Fail` 바로 아래에 일부러 버그 액션을 추가한다:
   ```
   BogusResurrect ==
       /\ state = "Completed"
       /\ state' = "InProgress"
   Next == Complete \/ Fail \/ BogusResurrect
   ```
   그 상태로 `FinalStatesAreStable`을 주석에 적힌 첫 번째(바깥쪽 [] 없는) 버전
   `(state = "Completed") => [](state = "Completed")` 형태로 바꿔서 TLC를 돌려본다
   — 이렇게 명백한 버그(Completed에서 InProgress로 되돌아감)를 넣었는데도
   TLC가 "No error"라고 답한다는 걸 직접 확인한다(공허하게 항상 참인 죽은
   속성이라는 뜻).
2. 이제 속성을 원래 형태인 `[](state = "Completed" => [](state = "Completed"))`로
   되돌리고 TLC를 다시 돌려본다 — 이번엔 BogusResurrect가 있는 채로도 진짜
   위반이 잡히는 걸 확인한다.

확인이 끝나면 BogusResurrect 액션과 Next 수정을 전부 제거해 원래 spec.tla 상태로
복원한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 spec.tla의 각 VARIABLES/액션에 왜 이렇게 정의했는지 설명하는 학습 주석이 있다
- [ ] #2 TLC 실행 결과 'Model checking completed. No error has been found.'를 직접 확인했다
- [ ] #3 바깥쪽 []가 없는 버전이 BogusResurrect를 못 잡는다는 걸 직접 재현했다
- [ ] #4 바깥쪽 []가 있는 올바른 버전은 BogusResurrect를 잡아낸다는 걸 직접 확인했다
<!-- AC:END -->
