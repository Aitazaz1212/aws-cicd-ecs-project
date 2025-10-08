output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution.arn
}

output "github_oidc_role_arn" {
  value = length(var.github_oidc_provider_arn) > 0 ? aws_iam_role.github_actions_oidc[0].arn : ""
}
