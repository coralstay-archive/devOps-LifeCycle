---
id: TASK-191.2
title: docker-compose로 app+Postgres 로컬 기동
status: To Do
assignee: []
created_date: '2026-09-05 03:25'
labels: []
dependencies: []
parent_task_id: TASK-191
type: task
ordinal: 405000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
docker-compose.yml에 app 컨테이너(위 Dockerfile로 빌드)와 postgres 컨테이너를 정의하고, app이 환경변수로 DB 접속 정보를 받아 postgres 컨테이너에 연결되도록 구성한다. 이건 로컬 개발/테스트 전용 구성이며 AWS RDS와는 무관하다.
<!-- SECTION:DESCRIPTION:END -->
