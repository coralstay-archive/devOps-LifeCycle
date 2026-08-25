module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  availability_zones = var.availability_zones
}

module "alb" {
  source = "../../modules/alb"

  name              = var.name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
}

module "waf" {
  source = "../../modules/waf-shield"

  name         = var.name
  scope        = "REGIONAL"
  resource_arn = module.alb.arn
}
