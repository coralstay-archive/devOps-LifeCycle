module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  cidr_block         = var.vpc_cidr
  availability_zones = var.availability_zones
  enable_nat_gateway = false
}

module "endpoints" {
  source = "../../modules/vpc-endpoints"

  vpc_id             = module.vpc.vpc_id
  vpc_cidr_block     = var.vpc_cidr
  region             = var.region
  private_subnet_ids = module.vpc.private_subnet_ids
  route_table_ids    = module.vpc.private_route_table_ids
}
