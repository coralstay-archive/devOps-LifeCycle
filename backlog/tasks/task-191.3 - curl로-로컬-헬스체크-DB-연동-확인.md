---
id: TASK-191.3
title: curl로 로컬 헬스체크 + DB 연동 확인
status: To Do
assignee: []
created_date: '2026-09-05 03:25'
labels: []
dependencies: []
parent_task_id: TASK-191
type: task
ordinal: 406000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
docker-compose up 상태에서 curl로 /health와 DB 연동 엔드포인트를 호출해 실제 응답(200, DB에서 읽은/쓴 값)을 확인한다. 이 결과가 확인돼야 TASK-192(ECR 푸시)로 넘어간다.
<!-- SECTION:DESCRIPTION:END -->
