resource "aws_ecs_cluster" "this" {
  name = "${var.project_name}-ecs-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${var.project_name}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.cluster_role_arn

  container_definitions = jsonencode([{
    name      = "app"
    image     = "${var.repo_url}:latest"
    essential = true
    portMappings = [{
      containerPort = var.app_port
      hostPort      = var.app_port
    }]
  }])
}

resource "aws_ecs_service" "this" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = [var.security_group_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "app"
    container_port   = var.app_port
  }

  depends_on = [aws_ecs_task_definition.app]
}
