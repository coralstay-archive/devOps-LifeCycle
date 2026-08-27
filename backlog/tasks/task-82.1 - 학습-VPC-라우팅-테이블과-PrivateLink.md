---
id: TASK-82.1
title: '학습: VPC 라우팅 테이블과 PrivateLink'
status: To Do
assignee: []
created_date: '2026-08-27 06:17'
labels: []
dependencies: []
documentation:
  - 'https://lamport.azurewebsites.net/tla/tla.html'
parent_task_id: TASK-82
type: docs
ordinal: 163000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Amazon VPC 공식 문서에서 라우팅 테이블과 VPC 엔드포인트(Gateway/Interface 타입)의 차이를 읽고, policy/ 디렉토리의 Conftest Rego 정책(s3_public_access.rego)처럼, 이 TLA+ 스펙이 잡는 '런타임 상태 불변식'과 Conftest가 잡는 '배포 전 정적 정책 검사'가 왜 서로 다른 방어선(defense in depth)인지 한 문단으로 정리한다.
<!-- SECTION:DESCRIPTION:END -->
