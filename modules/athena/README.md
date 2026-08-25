# athena

One workgroup pointed at an S3 results bucket. Query the tables a `glue` crawler catalogs.

## Status

Implemented (minimal).

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_output_location"></a> [output\_location](#input\_output\_location) | e.g. s3://my-bucket/athena-results/ | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_workgroup_name"></a> [workgroup\_name](#output\_workgroup\_name) | n/a |
<!-- END_TF_DOCS -->
