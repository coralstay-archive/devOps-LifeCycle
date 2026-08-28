# The control plane needs its own IAM role, separate from the worker nodes'
# role below — EKS itself (not your workloads) assumes this one to manage
# the Kubernetes API server, etcd, etc. on your behalf.
resource "aws_iam_role" "cluster" {
  name = "${var.cluster_name}-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "eks.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "cluster" {
  role       = aws_iam_role.cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# The control plane itself. Placed in private subnets — the managed control
# plane's ENIs live in your VPC even though AWS runs the actual servers.
resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster.arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids = var.private_subnet_ids
    # Free and strictly additive: lets nodes/pods reach the API server over
    # the VPC instead of only via the public endpoint. Doesn't disable
    # public access (see this module's README for that trade-off) — just
    # adds a second, private path.
    endpoint_private_access = true
  }

  # Only set when a KMS key is provided — encrypting Kubernetes Secrets at
  # rest is valuable but needs a real key (customer-managed or from the
  # `kms` module), so this stays opt-in rather than silently creating a key
  # this module didn't ask permission to own.
  dynamic "encryption_config" {
    for_each = var.secrets_kms_key_arn == null ? [] : [1]
    content {
      resources = ["secrets"]
      provider {
        key_arn = var.secrets_kms_key_arn
      }
    }
  }

  tags = var.tags

  # Explicit depends_on because Terraform can't infer this ordering from the
  # config alone: the API only lets EKS create a cluster after its role has
  # the cluster policy attached, but nothing here references the attachment
  # by name/output to make that dependency implicit.
  depends_on = [aws_iam_role_policy_attachment.cluster]
}

# Separate role for worker nodes (EC2 instances that actually run pods) —
# distinct from the cluster role above because nodes need EC2-level
# permissions (CNI networking, pulling from ECR), not control-plane
# permissions.
resource "aws_iam_role" "node" {
  name = "${var.cluster_name}-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

# Lets nodes register with the cluster and let kubelet manage pods on them.
resource "aws_iam_role_policy_attachment" "node_worker" {
  role       = aws_iam_role.node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# Lets the VPC CNI plugin attach/detach ENIs and assign pod IPs — without
# this, pods can't get networking at all.
resource "aws_iam_role_policy_attachment" "node_cni" {
  role       = aws_iam_role.node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

# Read-only ECR access so nodes can actually pull the container images
# they're scheduled to run.
resource "aws_iam_role_policy_attachment" "node_ecr" {
  role       = aws_iam_role.node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# The managed node group: the actual EC2 capacity pods run on. This is the
# "slower than Karpenter" scaling path noted in this module's README — see
# that file for why Karpenter isn't wired up yet.
resource "aws_eks_node_group" "default" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_name}-default"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = var.private_subnet_ids
  instance_types  = var.node_instance_types

  scaling_config {
    desired_size = var.node_desired_size
    min_size     = var.node_min_size
    max_size     = var.node_max_size
  }

  tags = var.tags

  # A self-contradictory scaling range (e.g. desired > max) would be accepted
  # by the type system but rejected by the EKS API at apply time with a less
  # obvious error — catching the logical inconsistency here is clearer.
  lifecycle {
    precondition {
      condition     = var.node_min_size <= var.node_desired_size && var.node_desired_size <= var.node_max_size
      error_message = "Scaling bounds must satisfy node_min_size <= node_desired_size <= node_max_size."
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_worker,
    aws_iam_role_policy_attachment.node_cni,
    aws_iam_role_policy_attachment.node_ecr,
  ]
}
