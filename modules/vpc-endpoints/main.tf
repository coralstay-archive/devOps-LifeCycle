# Gateway endpoints (S3, DynamoDB) are free and work by adding routes to
# existing route tables — no ENIs, no hourly cost, unlike interface
# endpoints below. This is why private subnets can reach S3/DynamoDB with
# zero NAT gateway involved.
resource "aws_vpc_endpoint" "s3" {
  vpc_id          = var.vpc_id
  service_name    = "com.amazonaws.${var.region}.s3"
  route_table_ids = var.route_table_ids
  tags            = var.tags

  # A gateway endpoint attached to zero route tables is provisioned but
  # unreachable from anywhere — traffic only routes through it if a route
  # table actually points at it.
  lifecycle {
    precondition {
      condition     = length(var.route_table_ids) > 0
      error_message = "route_table_ids must not be empty — a gateway endpoint attached to no route tables is unreachable."
    }
  }
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id          = var.vpc_id
  service_name    = "com.amazonaws.${var.region}.dynamodb"
  route_table_ids = var.route_table_ids
  tags            = var.tags
}

# Interface endpoints (ECR, CloudWatch Logs, etc.) work differently from
# gateway endpoints: they're actual ENIs in your subnets with a security
# group, which is why they need one (unlike the gateway endpoints above).
resource "aws_security_group" "interface_endpoints" {
  name        = "vpc-endpoints-sg"
  description = "Allow HTTPS from within the VPC to interface endpoints"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.interface_endpoints.id
  cidr_ipv4         = var.vpc_cidr_block
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

# Defaults to ECR (api + dkr, both needed to pull images) and CloudWatch
# Logs — enough for ECS/EKS tasks in fully private subnets (no NAT) to pull
# images and ship logs, which is the core use case (private-vpc-only).
# private_dns_enabled = true means normal AWS SDK/CLI calls resolve to these
# endpoints automatically, no client-side URL changes needed.
resource "aws_vpc_endpoint" "interface" {
  for_each            = toset(var.interface_services)
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.${each.value}"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  security_group_ids  = [aws_security_group.interface_endpoints.id]
  private_dns_enabled = true

  tags = var.tags
}
