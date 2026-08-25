# Multi-region is the one case in this repo where a scenario declares its own
# providers — everywhere else that's left for live/ to fill in, but two
# regions can't be expressed without provider aliases declared somewhere.

provider "aws" {
  region = var.primary_region
}

provider "aws" {
  alias  = "secondary"
  region = var.secondary_region
}
