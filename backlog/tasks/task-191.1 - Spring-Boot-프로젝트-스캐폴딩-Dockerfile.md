---
id: TASK-191.1
title: Spring Boot 프로젝트 스캐폴딩 + Dockerfile
status: To Do
assignee: []
created_date: '2026-09-05 03:24'
labels: []
dependencies: []
parent_task_id: TASK-191
type: task
ordinal: 404000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Gradle 기반 Spring Boot 프로젝트를 새로 생성한다 (예: modules/ 형제 위치가 아니라 이 프로젝트와 분리된 app/ 디렉토리 정도가 적당 -- 정확한 위치는 실행 시 판단). GET /health 엔드포인트(단순 200 OK)와 GET /hello 또는 유사한 Postgres 연동 엔드포인트(Spring Data JPA/JDBC로 테이블 하나 read/write)를 포함한다. 멀티스테이지 Dockerfile을 같이 작성해 AWS ECR에 푸시할 이미지를 빌드할 수 있게 한다.
<!-- SECTION:DESCRIPTION:END -->
