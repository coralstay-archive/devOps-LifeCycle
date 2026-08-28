output "state_machine_arn" {
  description = "ARN of the state machine -- pass this to StartExecution calls or EventBridge targets."
  value       = aws_sfn_state_machine.this.arn
}

output "role_arn" {
  description = "ARN of the IAM role Step Functions assumes to execute the state machine (has policy_arns attached, plus logging/X-Ray permissions)."
  value       = aws_iam_role.this.arn
}
