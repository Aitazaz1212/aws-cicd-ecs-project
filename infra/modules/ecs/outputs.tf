output "cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "service_arn" {
  value = aws_ecs_service.this.arn
}

output "task_def_arn" {
  value = aws_ecs_task_definition.app.arn
}
