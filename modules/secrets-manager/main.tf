resource "aws_secretsmanager_secret" "this" {
  name = var.name
  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "this" {
  count         = var.secret_string == null ? 0 : 1
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = var.secret_string
}
