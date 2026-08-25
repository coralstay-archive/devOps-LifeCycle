provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "aws-launcher"
      Scenario    = "standard-web"
      Environment = "dev"
      ManagedBy   = "terraform"
    }
  }
}
