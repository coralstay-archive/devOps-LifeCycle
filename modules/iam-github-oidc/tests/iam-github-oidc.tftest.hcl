# aws_iam_policy_document's .json is computed locally by the provider (no
# real API call either way), but Terraform's mock_provider fakes it along
# with everything else once "aws" is mocked — so this file tests the
# structural wiring (which resource/data source gets created) rather than
# the exact trust-policy string content, which mocking makes untestable
# without real AWS credentials.

mock_provider "aws" {
  # Without this override, the mock generates a schema-valid-but-not-JSON
  # fake string for this data source's .json attribute, which then fails
  # aws_iam_role's own plan-time "is this valid JSON" validation on
  # assume_role_policy. A minimal valid policy document sidesteps that —
  # this test isn't checking the trust policy's content anyway (see the
  # file header), just which resources/data sources get created.
  override_data {
    target = data.aws_iam_policy_document.trust
    values = {
      json = "{\"Version\":\"2012-10-17\",\"Statement\":[]}"
    }
  }
}

mock_provider "tls" {
  override_data {
    target = data.tls_certificate.github
    values = {
      certificates = [
        { sha1_fingerprint = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" },
      ]
    }
  }
}

run "creates_new_oidc_provider_by_default" {
  variables {
    github_org  = "acme"
    github_repo = "widgets"
    role_name   = "test-role"
  }

  assert {
    condition     = length(aws_iam_openid_connect_provider.github) == 1
    error_message = "create_oidc_provider defaults to true, should create a provider"
  }

  assert {
    condition     = length(data.aws_iam_openid_connect_provider.github) == 0
    error_message = "should not look up an existing provider when creating a new one"
  }
}

run "reuses_existing_oidc_provider_when_disabled" {
  variables {
    github_org           = "acme"
    github_repo          = "widgets"
    role_name            = "test-role-second-call"
    create_oidc_provider = false
  }

  assert {
    condition     = length(aws_iam_openid_connect_provider.github) == 0
    error_message = "create_oidc_provider = false should not create a second provider (only one allowed per account)"
  }

  assert {
    condition     = length(data.aws_iam_openid_connect_provider.github) == 1
    error_message = "create_oidc_provider = false should look up the existing provider instead"
  }
}
