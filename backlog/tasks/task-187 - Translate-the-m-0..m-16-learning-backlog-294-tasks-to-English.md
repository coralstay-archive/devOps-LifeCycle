---
id: TASK-187
title: Translate the m-0..m-16 learning backlog (294 tasks) to English
status: To Do
assignee: []
created_date: '2026-08-29 12:40'
labels: []
milestone: m-20
dependencies:
  - TASK-183
type: task
ordinal: 379000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
The entire m-0..m-16 learning backlog (parent + child task files, plus each
milestone file's own description) is written in Korean by original design
-- 294 of 358 backlog task files matched a Korean-character grep. Translate
titles and descriptions to English, batched below by milestone (one child
task per m-0..m-16, matching the 17 milestones), each independently
completable via `backlog task list -m "<milestone>" --plain`. Apply
TASK-183's terminology convention -- these titles/descriptions reference a
lot of AWS/Terraform terms (e.g. "학습: vpc 모듈 이해하기" -> the module name
and any AWS/Terraform concepts named should be sourced, not just
transliterated).

Note: this changes the learning backlog from Korean to English -- the repo
owner confirmed this is intended, not incidental to translating the READMEs.
<!-- SECTION:DESCRIPTION:END -->
