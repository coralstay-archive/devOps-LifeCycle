# organizations-landing-zone

Creates a couple of Organizational Units directly under the org root. Must be run from the AWS Organizations **management account**, and Organizations must already be enabled (this module doesn't enable it).

## Status

Implemented (minimal): OU structure only.

## Not yet included

Control Tower itself isn't a plain Terraform resource — it's a separate AWS service you enable via the console/API, after which it manages its own guardrails. This module only creates OUs; it doesn't set up Control Tower, SCPs, or account vending. Add SCPs (`aws_organizations_policy` + `aws_organizations_policy_attachment`) when `multi-account-landing-zone` needs actual guardrails, not just structure.

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_organizational_units"></a> [organizational\_units](#input\_organizational\_units) | OU names to create directly under the org root | `list(string)` | <pre>[<br/>  "Security",<br/>  "Workloads"<br/>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_ou_ids"></a> [ou\_ids](#output\_ou\_ids) | n/a |
<!-- END_TF_DOCS -->
