resource "aws_iam_role" "this" {
  name = "${var.name}-codedeploy-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "codedeploy.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
}

# compute_platform = "ECS" specifically — CodeDeploy also supports EC2/
# on-premises and Lambda platforms, but this module is scoped to ECS
# blue/green only.
resource "aws_codedeploy_app" "this" {
  name             = var.name
  compute_platform = "ECS"
}

resource "aws_codedeploy_deployment_group" "this" {
  app_name               = aws_codedeploy_app.this.name
  deployment_group_name  = "${var.name}-dg"
  service_role_arn       = aws_iam_role.this.arn
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"

  # BLUE_GREEN + WITH_TRAFFIC_CONTROL: CodeDeploy manages two ECS task sets
  # and shifts the ALB target group traffic between them, rather than ECS's
  # own default rolling-update behavior.
  deployment_style {
    deployment_type   = "BLUE_GREEN"
    deployment_option = "WITH_TRAFFIC_CONTROL"
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }
    # Old (blue) tasks are kept alive for 5 minutes after the new (green)
    # tasks take over traffic — a safety window to roll back into if
    # something looks wrong, before they're actually terminated.
    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }

  ecs_service {
    cluster_name = var.ecs_cluster_name
    service_name = var.ecs_service_name
  }

  # The core of blue/green: one listener, two target groups. CodeDeploy
  # shifts which target group the listener sends production traffic to.
  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [var.prod_listener_arn]
      }
      target_group {
        name = var.target_group_blue_name
      }
      target_group {
        name = var.target_group_green_name
      }
    }
  }

  tags = var.tags

  # The single most common copy-paste mistake with this pattern: pointing
  # blue and green at the same target group, which makes "shifting traffic
  # between them" meaningless.
  lifecycle {
    precondition {
      condition     = var.target_group_blue_name != var.target_group_green_name
      error_message = "target_group_blue_name and target_group_green_name must be different target groups."
    }
  }
}
