---
id: TASK-191
title: Spring Boot 앱 작성 + 로컬 docker-compose 검증
status: To Do
assignee: []
created_date: '2026-09-05 03:23'
labels: []
milestone: m-22
dependencies: []
type: task
ordinal: 400000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
이 저장소엔 아직 애플리케이션 소스가 전혀 없다 (scenarios/standard-web은 placeholder nginx 이미지로 plan/apply만 되는 상태). AWS에 배포하기 전에 로컬에서 완전히 독립적으로 검증 가능한 최소 Spring Boot 앱을 새로 작성한다 -- health-check 엔드포인트 하나와 Postgres에 실제로 읽기/쓰기를 하는 엔드포인트 하나 정도면 충분하다. 로컬 DB는 docker-compose로 띄우는 Postgres 컨테이너이며, 이건 AWS의 rds-postgres 모듈과는 별개(도커 DB를 AWS에 올리는 게 아님 -- 로컬 개발/테스트 전용). AWS 의존성(TASK-177/178)과 무관하게 먼저 진행 가능.
<!-- SECTION:DESCRIPTION:END -->
