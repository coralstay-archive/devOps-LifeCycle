# HTTP API (v2), not REST API (v1) — simpler and cheaper for the common case
# of "proxy everything to one Lambda," which is exactly what this module
# does.
resource "aws_apigatewayv2_api" "this" {
  name          = var.name
  protocol_type = "HTTP"
}

# AWS_PROXY integration: API Gateway forwards the raw request to Lambda and
# returns whatever Lambda responds with, rather than requiring a request/
# response mapping template — the Lambda function does its own routing.
resource "aws_apigatewayv2_integration" "lambda" {
  api_id                 = aws_apigatewayv2_api.this.id
  integration_type       = "AWS_PROXY"
  integration_uri        = var.lambda_invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "this" {
  api_id    = aws_apigatewayv2_api.this.id
  route_key = var.route_key
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"

  # NONE (default) preserves this module's original behavior -- the route
  # accepts unauthenticated requests and the Lambda behind it does its own
  # auth if needed. Not forced on by default: requiring an authorizer here
  # would be a breaking change for every existing caller of this module.
  authorization_type = var.authorization_type
  authorizer_id      = var.authorizer_id

  # route_key has an exact grammar API Gateway expects — either the literal
  # "$default" catch-all, or "<METHOD> /path". Anything else is a typo that
  # would otherwise surface as a confusing 404 at request time instead of a
  # clear error now.
  lifecycle {
    precondition {
      condition     = var.route_key == "$default" || can(regex("^(GET|POST|PUT|DELETE|PATCH|OPTIONS|HEAD|ANY) ", var.route_key))
      error_message = "route_key must be \"$default\" or \"<METHOD> /path\" (e.g. \"GET /items\")."
    }

    # JWT/CUSTOM authorizers need an actual authorizer resource to check
    # against; AWS_IAM and NONE don't take an authorizer_id at all. Catches
    # a plan-time-valid-looking but broken combination before it fails at
    # apply with a much less specific API error.
    precondition {
      condition     = !contains(["JWT", "CUSTOM"], var.authorization_type) || var.authorizer_id != null
      error_message = "authorizer_id must be set when authorization_type is \"JWT\" or \"CUSTOM\"."
    }
  }
}

# Unconditional, not opt-in — access logging was a total gap (no log group
# at all), not just a defaulted-off feature, and the CloudWatch ingestion
# cost here is minor (JSON access-log lines, not full request/response
# bodies).
resource "aws_cloudwatch_log_group" "access_logs" {
  name              = "/aws/apigateway/${var.name}"
  retention_in_days = var.log_retention_days
  tags              = var.tags
}

# auto_deploy means every change to routes/integrations goes live
# immediately — no separate "deploy" step to remember, appropriate for a
# module meant to stay simple.
resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.this.id
  name        = "$default"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.access_logs.arn
    format = jsonencode({
      requestId        = "$context.requestId"
      ip               = "$context.identity.sourceIp"
      requestTime      = "$context.requestTime"
      httpMethod       = "$context.httpMethod"
      routeKey         = "$context.routeKey"
      status           = "$context.status"
      protocol         = "$context.protocol"
      responseLength   = "$context.responseLength"
      integrationError = "$context.integrationErrorMessage"
    })
  }
}

# Without this, API Gateway can build the route/integration just fine but
# Lambda will reject the actual invocation — Lambda requires an explicit
# resource-policy grant naming exactly which API Gateway resource is allowed
# to invoke it.
resource "aws_lambda_permission" "apigateway" {
  statement_id  = "AllowAPIGatewayInvoke-${var.name}"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.this.execution_arn}/*/*"
}
