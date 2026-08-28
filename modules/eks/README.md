# eks

EKS cluster + one managed node group, minimal IAM wiring (cluster role, node role with worker/CNI/ECR-readonly policies).

## Status

Implemented (minimal): base cluster + managed node group only.

## Not yet included (documented gap, not silently missing)

**Karpenter is not wired up yet**, despite being the original point of this module for spike traffic (see `scenarios/high-traffic-spike`). Karpenter needs a Helm release + its own IAM role/instance profile + `NodePool`/`EC2NodeClass` Kubernetes CRDs, which means Terraform's `helm`/`kubernetes` providers — a bigger addition than "minimal." Until then, react to spikes via `node_max_size` headroom on the managed node group (slower than Karpenter, but functional). Add Karpenter when `high-traffic-spike` is actually implemented.

IRSA, multiple node groups: also not included.

Checkov/Trivy findings that are real, accepted trade-offs:
- **Public API endpoint open to 0.0.0.0/0** — this is the actual AWS default when `endpoint_public_access`/`public_access_cidrs` aren't set, which is what lets you run `kubectl`/`terraform` from a laptop without a VPN into the VPC. `endpoint_private_access = true` is now on too (free, lets in-VPC traffic use a private path), but disabling public access entirely means every cluster interaction has to go through something inside the VPC (bastion, VPN, Cloud9) — a real operational cost this minimal module doesn't force on you. Set `public_access_cidrs` to your own IP range, or add a variable to disable public access entirely, once a scenario needs it.
- **Control plane logging not enabled** (`enabled_cluster_log_types`) — a real cost trade-off: CloudWatch Logs ingestion for `api`/`audit`/`authenticator`/`controllerManager`/`scheduler` logs isn't free at scale. Add when a scenario needs control-plane audit trails.
- **Secrets encryption available but opt-in** — pass `secrets_kms_key_arn` (e.g. from the `kms` module) to encrypt Kubernetes Secrets at rest with envelope encryption. Left off by default because it needs a real KMS key this module won't silently create on your behalf.

## 런타임 불변식 (precondition/postcondition)

`aws_eks_node_group.default`에 `precondition`을 달아, `node_min_size <= node_desired_size <= node_max_size`인지 검증한다.

## 공식문서

- [Amazon EKS 사용 설명서](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)
- [EKS Best Practices: Karpenter](https://docs.aws.amazon.com/eks/latest/best-practices/karpenter.html)
- [Karpenter 공식 문서](https://karpenter.sh/docs/)
- Terraform: [`aws_eks_cluster`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster), [`aws_eks_node_group`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group)

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
