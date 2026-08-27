locals {
  az_count = length(var.availability_zones)
}

# The VPC itself: an isolated IPv4 address space. DNS support/hostnames are
# needed for things like RDS endpoints and ECS service discovery to resolve.
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.tags, { Name = var.name })
}

# Without an IGW, nothing in this VPC (public or private) can reach the
# public internet at all — it's the door, not the traffic control.
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, { Name = "${var.name}-igw" })
}

# One public subnet per AZ. "Public" here just means its route table sends
# 0.0.0.0/0 to the IGW (below) — the subnet itself has no inherent publicness.
resource "aws_subnet" "public" {
  count                   = local.az_count
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.cidr_block, 4, count.index)
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = merge(var.tags, { Name = "${var.name}-public-${var.availability_zones[count.index]}" })
}

# One private subnet per AZ, offset in the CIDR block past the public ones
# (cidrsubnet's count.index + az_count keeps the two ranges from overlapping).
resource "aws_subnet" "private" {
  count             = local.az_count
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.cidr_block, 4, count.index + local.az_count)
  availability_zone = var.availability_zones[count.index]

  tags = merge(var.tags, { Name = "${var.name}-private-${var.availability_zones[count.index]}" })
}

# A NAT gateway needs a fixed public IP to present as the source address for
# outbound traffic from private subnets — one EIP per AZ's NAT gateway.
resource "aws_eip" "nat" {
  count  = var.enable_nat_gateway ? local.az_count : 0
  domain = "vpc"

  tags = merge(var.tags, { Name = "${var.name}-nat-eip-${count.index}" })
}

# One NAT gateway per AZ (not one shared NAT for the whole VPC): a single NAT
# gateway is both a bandwidth bottleneck and a single point of failure if its
# AZ goes down — exactly the kind of spike/availability tradeoff this repo's
# SRE principles call out. Costs more than one shared NAT, but that's the
# point of the tradeoff.
resource "aws_nat_gateway" "this" {
  count         = var.enable_nat_gateway ? local.az_count : 0
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = merge(var.tags, { Name = "${var.name}-nat-${count.index}" })

  depends_on = [aws_internet_gateway.this]
}

# Public subnets all share one route table: they all just need "internet
# traffic goes to the IGW," so there's no reason to duplicate it per AZ.
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(var.tags, { Name = "${var.name}-public-rt" })
}

resource "aws_route_table_association" "public" {
  count          = local.az_count
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Private route tables, by contrast, are per-AZ when NAT is enabled — each
# private subnet's outbound traffic must go through *its own AZ's* NAT
# gateway, not a neighboring AZ's (that would defeat the point of having one
# NAT per AZ, and adds a cross-AZ data transfer cost). When NAT is disabled
# (private-vpc-only style), one shared table with no default route is enough.
resource "aws_route_table" "private" {
  count  = var.enable_nat_gateway ? local.az_count : 1
  vpc_id = aws_vpc.this.id

  dynamic "route" {
    for_each = var.enable_nat_gateway ? [1] : []
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.this[count.index].id
    }
  }

  tags = merge(var.tags, { Name = "${var.name}-private-rt-${count.index}" })
}

resource "aws_route_table_association" "private" {
  count          = local.az_count
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = var.enable_nat_gateway ? aws_route_table.private[count.index].id : aws_route_table.private[0].id
}
