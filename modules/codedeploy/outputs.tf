output "app_name" {
  description = "CodeDeploy application name -- used with the AWS CLI/console/CI pipeline to trigger deployments."
  value       = aws_codedeploy_app.this.name
}

output "deployment_group_name" {
  description = "Deployment group name -- the target for a CreateDeployment call."
  value       = aws_codedeploy_deployment_group.this.deployment_group_name
}
