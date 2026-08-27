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

# resource_arn = alb.arn (the plain ARN, not arn_suffix) — WAF's
# association resource needs the full ALB ARN, which is a different output
# than what CloudWatch metric dimensions would want (arn_suffix).
# scope = "REGIONAL" (the default) is what makes this association actually
# apply, per the waf-shield module's own scope-gating logic.
module "waf" {
  source = "../../modules/waf-shield"

  name         = var.name
  scope        = "REGIONAL"
  resource_arn = module.alb.arn
}
