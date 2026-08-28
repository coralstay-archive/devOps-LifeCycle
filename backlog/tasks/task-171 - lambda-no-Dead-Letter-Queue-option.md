---
id: TASK-171
title: 'lambda: no Dead Letter Queue option'
status: Done
assignee: []
created_date: '2026-08-28 04:32'
updated_date: '2026-08-28 09:17'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 333000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_116 — add opt-in dead_letter_target_arn variable (pairs naturally with modules/sns-sqs).
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added dead_letter_target_arn variable, wired into a dynamic dead_letter_config block. Implemented by the lambda/step-functions fork, but incorrectly recorded against TASK-172 due to a task-ID mislabeling in the coordinating session's fork instructions -- corrected here.
<!-- SECTION:FINAL_SUMMARY:END -->
