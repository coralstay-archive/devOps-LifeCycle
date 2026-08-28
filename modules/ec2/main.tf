# Only look up a default AMI when the caller didn't pin one. count-gating a
# data source like this (instead of always querying it) avoids an
# unnecessary API call/dependency when var.ami_id is already known.
data "aws_ami" "amazon_linux" {
  count       = var.ami_id == null ? 1 : 0
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_instance" "this" {
  ami                         = var.ami_id != null ? var.ami_id : data.aws_ami.amazon_linux[0].id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  iam_instance_profile        = var.iam_instance_profile
  user_data                   = var.user_data
  # Free on every current-generation instance type (t3, m5, etc.) — EBS
  # optimization is already the API default for them, this just makes it
  # explicit instead of relying on that default silently holding.
  ebs_optimized = true
  # Real per-instance cost when on (1-minute metrics vs. the free 5-minute
  # default) — off by default so this scaffold doesn't silently bill for it.
  monitoring = var.enable_detailed_monitoring

  # Encrypted by default — there's no reason a fresh EC2 instance's root
  # volume should ever be unencrypted, and AWS doesn't default to encrypted
  # unless you ask.
  root_block_device {
    volume_size = var.root_volume_size
    encrypted   = true
  }

  # IMDSv2 (http_tokens = "required") forces callers to fetch a session token
  # before reading instance metadata. IMDSv1 lets any process that can make
  # an HTTP request to 169.254.169.254 read the instance's IAM credentials —
  # the exact path the Capital One 2019 breach used via an SSRF
  # vulnerability. Requiring v2 closes that off.
  metadata_options {
    http_tokens = "required"
  }

  tags = merge(var.tags, { Name = var.name })

  # 8 GB is Amazon Linux 2023's actual minimum — below that the instance
  # can't even boot, so this fails at plan time instead of a confusing
  # instance-launch failure.
  lifecycle {
    precondition {
      condition     = var.root_volume_size >= 8
      error_message = "root_volume_size must be at least 8 GB (Amazon Linux 2023's minimum root volume size)."
    }
  }
}
