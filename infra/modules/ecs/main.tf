# ECS Cluster
resource "aws_ecs_cluster" "this" {
  name = "${var.project_name}-cluster"
}

# CloudWatch Log Group for ECS
resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/${var.project_name}"
  retention_in_days = 14
}

# ECS Task Definition (for EC2 launch type)
resource "aws_ecs_task_definition" "app" {
  family                   = "${var.project_name}-task"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.cluster_role_arn

  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "${var.repo_url}:latest"
      essential = true

      portMappings = [
        {
          containerPort = var.app_port
          hostPort      = var.app_port
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/${var.project_name}"
          awslogs-region        = data.aws_region.current.name
          awslogs-stream-prefix = "app"
        }
      }
    }
  ])
}

data "aws_region" "current" {}

# Target group for ALB to forward traffic
resource "aws_lb_target_group" "ecs_tg" {
  name     = "${var.project_name}-tg"
  port     = var.app_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }

  tags = {
    Name = "${var.project_name}-tg"
  }
}

# ECS Service (using EC2 instances)
resource "aws_ecs_service" "app" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 2
  launch_type     = "EC2"

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_tg.arn
    container_name   = "app"
    container_port   = var.app_port
  }

  depends_on = [
    aws_cloudwatch_log_group.ecs
  ]
}

# Outputs
output "service_arn" {
  value = aws_ecs_service.app.arn
}

output "cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "target_group_arn" {
  value = aws_lb_target_group.ecs_tg.arn
}
