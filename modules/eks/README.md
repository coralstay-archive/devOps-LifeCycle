# eks

EKS cluster + one managed node group, minimal IAM wiring (cluster role, node role with worker/CNI/ECR-readonly policies).

## Status

Implemented (minimal): base cluster + managed node group only.

## Not yet included (documented gap, not silently missing)

**Karpenter is not wired up yet**, despite being the original point of this module for spike traffic (see `scenarios/high-traffic-spike`). Karpenter needs a Helm release + its own IAM role/instance profile + `NodePool`/`EC2NodeClass` Kubernetes CRDs, which means Terraform's `helm`/`kubernetes` providers — a bigger addition than "minimal." Until then, react to spikes via `node_max_size` headroom on the managed node group (slower than Karpenter, but functional). Add Karpenter when `high-traffic-spike` is actually implemented.

IRSA, private-only API endpoint toggle, multiple node groups: also not included.

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | n/a | `string` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | n/a | `string` | `"1.31"` | no |
| <a name="input_node_desired_size"></a> [node\_desired\_size](#input\_node\_desired\_size) | n/a | `number` | `2` | no |
| <a name="input_node_instance_types"></a> [node\_instance\_types](#input\_node\_instance\_types) | n/a | `list(string)` | <pre>[<br/>  "t3.medium"<br/>]</pre> | no |
| <a name="input_node_max_size"></a> [node\_max\_size](#input\_node\_max\_size) | n/a | `number` | `4` | no |
| <a name="input_node_min_size"></a> [node\_min\_size](#input\_node\_min\_size) | n/a | `number` | `2` | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | Needs >= 2 AZs; used for both the control plane ENIs and worker nodes | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | n/a |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | n/a |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |
| <a name="output_node_role_arn"></a> [node\_role\_arn](#output\_node\_role\_arn) | n/a |
<!-- END_TF_DOCS -->
