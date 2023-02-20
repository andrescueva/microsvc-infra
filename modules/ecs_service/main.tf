resource "aws_ecs_task_definition" "task" {
  family                   = "microsvc"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = var.task_memory
  cpu                      = var.task_cpu
  container_definitions    = <<DEFINITION
  [
    {
      "name": "microsvc",
      "image": "image",
      "portMappings": [
        {
          "containerPort": 8000,
          "protocol": "tcp"
        }
      ]
    }
  ]
  DEFINITION
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

resource "aws_ecs_service" "svc" {
  name            = "microsvc"
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = var.min_capacity

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.lb_target_group_arn
    container_name   = "microsvc"
    container_port   = var.container_port
  }

  launch_type      = "FARGATE"
  platform_version = "LATEST"
  deployment_controller {
    type = "ECS"
  }
}

resource "aws_appautoscaling_target" "my_scaling_target" {
  max_capacity       = var.max_capacity
  min_capacity       = var.min_capacity
  resource_id        = "service/${var.ecs_cluster_name}/${aws_ecs_service.svc.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "my_scaling_policy" {
  name               = "my-scaling-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.my_scaling_target.resource_id
  scalable_dimension = aws_appautoscaling_target.my_scaling_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.my_scaling_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
    target_value       = 80.0
  }
}


resource "aws_iam_role" "ecs_task_execution" {
  name = "ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.ecs_task_execution.name
}
