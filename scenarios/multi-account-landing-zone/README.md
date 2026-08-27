# multi-account-landing-zone

**카테고리**: 네트워크/보안
**설명**: Organizations+Control Tower 기반 멀티 계정 랜딩존.

## 상태

composed — `organizations-landing-zone` 모듈을 그대로 노출. **관리 계정(management account)에서만 apply 가능**하며 Organizations가 이미 활성화돼 있어야 한다. Control Tower 자체는 포함하지 않음(해당 모듈 README 참고).

## 관련 모듈

organizations-landing-zone

## 참고자료

- 관련 모듈 문서: `organizations-landing-zone`

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_organizational_units"></a> [organizational\_units](#input\_organizational\_units) | n/a | `list(string)` | <pre>[<br/>  "Security",<br/>  "Workloads"<br/>]</pre> | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_ou_ids"></a> [ou\_ids](#output\_ou\_ids) | n/a |
<!-- END_TF_DOCS -->