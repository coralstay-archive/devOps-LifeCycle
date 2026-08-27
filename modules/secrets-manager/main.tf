resource "aws_secretsmanager_secret" "this" {
  name = var.name
  tags = var.tags

  lifecycle {
    postcondition {
      condition     = startswith(self.arn, "arn:aws:secretsmanager:")
      error_message = "Secret ARN must be a well-formed Secrets Manager ARN."
    }
  }
}

resource "aws_secretsmanager_secret_version" "this" {
  count         = var.secret_string == null ? 0 : 1
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = var.secret_string
}
