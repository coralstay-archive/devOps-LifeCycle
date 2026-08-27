# No `providers = {...}` meta-argument means this call implicitly uses the
# default (primary-region) provider declared in providers.tf.
module "vpc_primary" {
  source = "../../modules/vpc"

  name               = "${var.name}-primary"
  availability_zones = var.primary_azs
}

# The `providers` meta-argument is what actually makes this a second-region
# deployment — everything else about this module call is identical to
# vpc_primary above, just routed through the aliased provider instead.
module "vpc_secondary" {
  source = "../../modules/vpc"
  providers = {
    aws = aws.secondary
  }

  name               = "${var.name}-secondary"
  availability_zones = var.secondary_azs
}

# Route53 is a global service (not region-scoped like the VPCs above), so it
# uses the default provider regardless of which region that resolves to —
# there's no "secondary Route53."
module "dns" {
  source      = "../../modules/route53"
  domain_name = var.domain_name
}
