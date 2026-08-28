---
id: TASK-173
title: 'lambda: no code-signing configuration'
status: Done
assignee: []
created_date: '2026-08-28 04:32'
updated_date: '2026-08-28 09:58'
labels: []
milestone: m-17
dependencies: []
type: bug
ordinal: 335000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
checkov CKV_AWS_272 — needs a signing profile set up out-of-band (AWS Signer); bigger lift, lower priority for a learning scaffold.
<!-- SECTION:DESCRIPTION:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added code_signing_config_arn variable (default null), wired into aws_lambda_function.code_signing_config_arn. Bring-your-own-Signer-profile pattern -- module doesn't create the AWS Signer profile itself, same reasoning as the ALB/CloudFront bring-your-own-log-bucket variables.
<!-- SECTION:FINAL_SUMMARY:END -->
