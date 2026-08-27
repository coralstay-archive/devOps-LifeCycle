# GitHub's OIDC token issuer publishes its own TLS certificate; AWS needs
# that certificate's thumbprint to trust tokens signed by it. This data
# source fetches it live rather than hardcoding a thumbprint that could
# silently go stale if GitHub rotates their cert.
data "tls_certificate" "github" {
  count = var.create_oidc_provider ? 1 : 0
  url   = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}

# The trust relationship between AWS and GitHub's OIDC issuer. An AWS account
# can only register this once — hence create_oidc_provider, so a second
# caller in the same account can reuse it via the data source below instead
# of failing on a duplicate-provider error.
resource "aws_iam_openid_connect_provider" "github" {
  count = var.create_oidc_provider ? 1 : 0

  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.github[0].certificates[0].sha1_fingerprint]

  tags = var.tags
}

# The reuse path: look up the OIDC provider someone else's call to this
# module already created, instead of trying (and failing) to create a
# second one.
data "aws_iam_openid_connect_provider" "github" {
  count = var.create_oidc_provider ? 0 : 1
  url   = "https://token.actions.githubusercontent.com"
}

locals {
  oidc_provider_arn = var.create_oidc_provider ? aws_iam_openid_connect_provider.github[0].arn : data.aws_iam_openid_connect_provider.github[0].arn
}

# The actual trust policy: WHO can assume this role, scoped tightly to one
# GitHub repo and one ref. The "aud" condition confirms the token is meant
# for AWS STS at all; the "sub" condition is what actually pins it to a
# specific repo/branch — without it, any GitHub Actions workflow anywhere
# could assume this role.
data "aws_iam_policy_document" "trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [local.oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github_org}/${var.github_repo}:ref:${var.allowed_ref}"]
    }
  }
}

# The role GitHub Actions actually assumes. No permissions of its own until
# policy_arns are attached below — this resource is purely "who can log in,"
# not "what they can do."
resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.trust.json

  tags = var.tags

  # Real-world footgun this catches: passing a bare branch name like "main"
  # instead of "refs/heads/main". GitHub's actual sub claim always includes
  # the refs/... prefix, so a bare branch name would plan/apply successfully
  # but then every workflow run would get an opaque AssumeRoleWithWebIdentity
  # AccessDenied at runtime, with nothing here to explain why.
  lifecycle {
    precondition {
      condition     = var.allowed_ref == "*" || can(regex("^refs/", var.allowed_ref))
      error_message = "allowed_ref must be \"*\" or a real git ref (e.g. refs/heads/main, refs/tags/v1.0.0) — a bare branch name silently never matches GitHub's actual sub claim."
    }
  }
}

# What the role can actually do once assumed — kept separate from trust so
# the "who" and "what" questions stay independently reviewable.
resource "aws_iam_role_policy_attachment" "this" {
  for_each   = toset(var.policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = each.value
}
