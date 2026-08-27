---
id: TASK-69.2
title: '실습: `specs/data-lake/spec.tla`를 직접 타이핑하며 학습 주석 달고 TLC로 검증하기'
status: To Do
assignee: []
created_date: '2026-08-27 06:43'
labels:
  - spec
  - tla
  - hands-on
dependencies: []
references:
  - specs/data-lake/spec.tla
parent_task_id: TASK-69
type: task
ordinal: 195000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/data-lake/spec.tla의 각 액션과 변수 정의를 직접 타이핑(복붙 금지)하면서, 왜 이렇게 정의했는지 학습 주석을 단다.

### 실행 검증 (직접 실행)

```bash
# 최초 1회만: TLA+ 도구 받기 (저장소에 커밋되어 있지 않음)
mkdir -p .tla-tools
curl -L -o .tla-tools/tla2tools.jar \
  https://github.com/tlaplus/tlaplus/releases/latest/download/tla2tools.jar

cd specs/data-lake
java -jar ../../.tla-tools/tla2tools.jar -config spec.cfg spec.tla
# 'Model checking completed. No error has been found.'가 나와야 정상
```

한 걸음 더 — 이 스펙엔 일부러 주석 처리해둔 '버그' 액션 `QueryBeforeCatalog`가 있다. 그 액션의 주석을 풀고 `Next` 정의에 `\/ QueryBeforeCatalog`를 추가한 뒤 TLC를 다시 돌려본다 — 불변식 위반 반례가 실제로 나오는 걸 확인하고 나면, 추가한 내용을 되돌려 원래 spec.tla 상태로 복원한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 spec.tla의 각 VARIABLES/액션에 왜 이렇게 정의했는지 설명하는 학습 주석이 있다
- [ ] #2 TLC 실행 결과 'Model checking completed. No error has been found.'를 직접 확인했다
- [ ] #3 QueryBeforeCatalog를 Next에 추가하면 불변식이 깨지는 걸 직접 재현했다
<!-- AC:END -->
