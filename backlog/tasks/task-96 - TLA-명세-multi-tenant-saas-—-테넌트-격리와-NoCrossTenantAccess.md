---
id: TASK-96
title: 'TLA+ 명세: multi-tenant-saas — 테넌트 격리와 NoCrossTenantAccess'
status: To Do
assignee: []
created_date: '2026-08-27 06:19'
updated_date: '2026-08-27 06:44'
labels: []
milestone: m-16
dependencies: []
references:
  - specs/multi-tenant-saas/spec.tla
type: spike
ordinal: 191000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
specs/multi-tenant-saas/spec.tla — '테넌트 A가 테넌트 B의 데이터를 절대 못 본다'는, Terraform으로는 표현할 수 없는 애플리케이션 레벨 격리 속성을 명세한다. spec.cfg에서 model value 선언(t1=t1 등)을 빠뜨리면 어떤 TLC 설정 오류가 나는지 직접 겪어본 뒤 고쳐서 재검증한다.

공식문서를 찾아보며 왜 이런 제약이 실제 AWS 서비스의 동작에 대응하는지 이해한 뒤, 아래 페어링된 실습 태스크에서 직접 타이핑하고 TLC로 검증한다.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 이 스펙이 모델링하는 시스템 동작(무엇이 상태 변수고 무엇이 액션인지)을 자신의 말로 설명할 수 있다
- [ ] #2 TypeInvariant, NoCrossTenantAccess이(가) 실제로 어떤 실패 시나리오를 막는지 설명할 수 있다
- [ ] #3 주석 처리된 ReadOtherTenantData(t, other) 액션이 왜 Next에 포함되면 안 되는지, 포함하면 어떤 불변식이 깨질지 설명할 수 있다
- [ ] #4 이 스펙을 만드는 과정에서 TLC가 실제로 찾아낸 문제가 무엇이었고 어떻게 고쳤는지 설명할 수 있다
<!-- AC:END -->
