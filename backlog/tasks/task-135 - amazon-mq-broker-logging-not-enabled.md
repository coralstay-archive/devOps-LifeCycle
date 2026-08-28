---
id: TASK-135
title: 'amazon-mq: broker logging not enabled'
status: Done
assignee: []
created_date: '2026-08-28 04:30'
updated_date: '2026-08-28 04:40'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 297000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_48 / trivy AWS-0070,AWS-0071 — no logs block at all on aws_mq_broker. Enable general+audit CloudWatch logging by default (negligible cost, matches the 'fixed for free' pattern from the prior audit).
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added unconditional logs { general = true, audit = engine_type == "ActiveMQ" } block — general is free/always-on, audit is gated since RabbitMQ (the default engine) rejects it at broker-creation time. validate passes.
<!-- SECTION:FINAL_SUMMARY:END -->
