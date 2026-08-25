mock_provider "aws" {}

run "one_subnet_pair_per_az" {
  variables {
    name               = "test-vpc"
    availability_zones = ["ap-northeast-2a", "ap-northeast-2c"]
  }

  assert {
    condition     = length(output.public_subnet_ids) == 2
    error_message = "expected one public subnet per AZ"
  }

  assert {
    condition     = length(output.private_subnet_ids) == 2
    error_message = "expected one private subnet per AZ"
  }

  assert {
    condition     = length(aws_nat_gateway.this) == 2
    error_message = "expected one NAT gateway per AZ when enable_nat_gateway is true (the default)"
  }
}

run "disabling_nat_gateway_skips_nat_but_keeps_private_subnets" {
  variables {
    name               = "test-vpc-no-nat"
    availability_zones = ["ap-northeast-2a", "ap-northeast-2c"]
    enable_nat_gateway = false
  }

  assert {
    condition     = length(aws_nat_gateway.this) == 0
    error_message = "no NAT gateways should be created when enable_nat_gateway is false"
  }

  assert {
    condition     = length(output.private_subnet_ids) == 2
    error_message = "private subnets should still exist without NAT (private-vpc-only scenario)"
  }
}
