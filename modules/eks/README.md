# eks

EKS cluster + one managed node group, minimal IAM wiring (cluster role, node role with worker/CNI/ECR-readonly policies).

## Status

Implemented (minimal): base cluster + managed node group only.

## Not yet included (documented gap, not silently missing)

**Karpenter is not wired up yet**, despite being the original point of this module for spike traffic (see `scenarios/high-traffic-spike`). Karpenter needs a Helm release + its own IAM role/instance profile + `NodePool`/`EC2NodeClass` Kubernetes CRDs, which means Terraform's `helm`/`kubernetes` providers — a bigger addition than "minimal." Until then, react to spikes via `node_max_size` headroom on the managed node group (slower than Karpenter, but functional). Add Karpenter when `high-traffic-spike` is actually implemented.

IRSA, multiple node groups: also not included.

Checkov/Trivy findings that are real, accepted trade-offs:
- **Public API endpoint still defaults to 0.0.0.0/0** — `public_access_cidrs` is now a variable (previously there was no way to restrict this at all), but it still defaults open so `kubectl`/`terraform` work from a laptop without a VPN into the VPC. `endpoint_private_access = true` is on too (free, lets in-VPC traffic use a private path). Set `public_access_cidrs` to your own IP range once a scenario needs it locked down; disabling public access entirely is a bigger step (every cluster interaction then needs something inside the VPC — bastion, VPN, Cloud9) and isn't wired up as a toggle here.
- **Control plane logging off by default** (`cluster_log_types`, now a variable — previously not configurable at all) — a real cost trade-off: CloudWatch Logs ingestion for `api`/`audit`/`authenticator`/`controllerManager`/`scheduler` logs isn't free at scale, so the default stays `[]`. Pass the full list once a scenario needs control-plane audit trails.
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
| <a name="input_cluster_log_types"></a> [cluster\_log\_types](#input\_cluster\_log\_types) | Control plane log types to enable (e.g. ["api", "audit", "authenticator", "controllerManager", "scheduler"]). Defaults to none — enabling any incurs ongoing CloudWatch Logs cost. | `list(string)` | `[]` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster. | `string` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | EKS control plane Kubernetes version. | `string` | `"1.31"` | no |
| <a name="input_node_desired_size"></a> [node\_desired\_size](#input\_node\_desired\_size) | Desired node count for the default managed node group. Must satisfy node\_min\_size <= node\_desired\_size <= node\_max\_size. | `number` | `2` | no |
| <a name="input_node_instance_types"></a> [node\_instance\_types](#input\_node\_instance\_types) | EC2 instance types available to the default managed node group. | `list(string)` | <pre>[<br/>  "t3.medium"<br/>]</pre> | no |
| <a name="input_node_max_size"></a> [node\_max\_size](#input\_node\_max\_size) | Maximum node count the managed node group will scale up to. | `number` | `4` | no |
| <a name="input_node_min_size"></a> [node\_min\_size](#input\_node\_min\_size) | Minimum node count the managed node group will scale down to. | `number` | `2` | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | Needs >= 2 AZs; used for both the control plane ENIs and worker nodes | `list(string)` | n/a | yes |
| <a name="input_public_access_cidrs"></a> [public\_access\_cidrs](#input\_public\_access\_cidrs) | CIDR blocks allowed to reach the public API endpoint. Defaults to open (0.0.0.0/0) to preserve out-of-the-box kubectl access — narrow this for anything beyond a scaffold. | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_secrets_kms_key_arn"></a> [secrets\_kms\_key\_arn](#input\_secrets\_kms\_key\_arn) | KMS key ARN to encrypt Kubernetes Secrets at rest (e.g. from the kms module). Leave null to skip envelope encryption of Secrets. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to the cluster and node group. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | Base64-encoded cluster CA certificate, needed alongside cluster\_endpoint to configure a Kubernetes provider/kubeconfig. |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | API server endpoint for kubectl/the Kubernetes provider to talk to. |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Name of the EKS cluster. |
| <a name="output_node_role_arn"></a> [node\_role\_arn](#output\_node\_role\_arn) | ARN of the IAM role assumed by worker nodes in the default managed node group. |
<!-- END_TF_DOCS -->
