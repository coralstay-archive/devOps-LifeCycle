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

  root_block_device {
    volume_size = var.root_volume_size
    encrypted   = true
  }

  # IMDSv2 required by default — blocks the classic SSRF-to-credential-theft
  # path that IMDSv1 allows.
  metadata_options {
    http_tokens = "required"
  }

  tags = merge(var.tags, { Name = var.name })

  lifecycle {
    precondition {
      condition     = var.root_volume_size >= 8
      error_message = "root_volume_size must be at least 8 GB (Amazon Linux 2023's minimum root volume size)."
    }
  }
}
