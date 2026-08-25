resource "aws_vpc_endpoint" "s3" {
  vpc_id          = var.vpc_id
  service_name    = "com.amazonaws.${var.region}.s3"
  route_table_ids = var.route_table_ids
  tags            = var.tags
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id          = var.vpc_id
  service_name    = "com.amazonaws.${var.region}.dynamodb"
  route_table_ids = var.route_table_ids
  tags            = var.tags
}

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
