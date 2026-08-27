# The secret container itself — creating this doesn't require knowing the
# secret value yet, which is what makes the version resource below optional.
resource "aws_secretsmanager_secret" "this" {
  name = var.name
  tags = var.tags

  # Same "does this ARN look real" sanity check pattern as s3-bucket's
  # bucket_arn and sns-sqs's queue ARN — cheap, catches nothing in practice,
  # but establishes the convention this repo follows.
  lifecycle {
    postcondition {
      condition     = startswith(self.arn, "arn:aws:secretsmanager:")
      error_message = "Secret ARN must be a well-formed Secrets Manager ARN."
    }
  }
}

# Setting the actual value is optional and separate from creating the secret
# container — for anything that gets rotated, you'd typically leave this out
# and populate the value out-of-band (or via a rotation Lambda), so Terraform
# never holds the live value in state long-term.
resource "aws_secretsmanager_secret_version" "this" {
  count         = var.secret_string == null ? 0 : 1
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = var.secret_string
}
