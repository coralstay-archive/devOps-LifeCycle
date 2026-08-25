module "vpc_primary" {
  source = "../../modules/vpc"

  name               = "${var.name}-primary"
  availability_zones = var.primary_azs
}

module "vpc_secondary" {
  source = "../../modules/vpc"
  providers = {
    aws = aws.secondary
  }

  name               = "${var.name}-secondary"
  availability_zones = var.secondary_azs
}

module "dns" {
  source      = "../../modules/route53"
  domain_name = var.domain_name
}
