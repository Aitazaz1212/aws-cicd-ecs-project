output "service_arn" {
  value = aws_ecs_service.app.arn
}

output "cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "target_group_arn" {
  value = aws_lb_target_group.ecs_tg.arn
}
