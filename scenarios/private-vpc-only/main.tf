# enable_nat_gateway = false is the actual scenario-defining choice — no NAT
# means no outbound internet path at all unless the endpoints module below
# fills the specific gaps (S3, DynamoDB, ECR, Logs) that would otherwise
# require it.
module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  cidr_block         = var.vpc_cidr
  availability_zones = var.availability_zones
  enable_nat_gateway = false
}

# route_table_ids comes from vpc's private_route_table_ids output
# specifically (not the public one) — gateway endpoints only need to be
# reachable from the private subnets that have no other route out.
module "endpoints" {
  source = "../../modules/vpc-endpoints"

  vpc_id             = module.vpc.vpc_id
  vpc_cidr_block     = var.vpc_cidr
  region             = var.region
  private_subnet_ids = module.vpc.private_subnet_ids
  route_table_ids    = module.vpc.private_route_table_ids
}
