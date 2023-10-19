resource "aws_ecs_cluster" "ecs_cluster" {
  name = "my-cluster"
}

resource "aws_ecs_service" "frontend" {
  name            = "surfy-frontend-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.frontend-image.arn

  launch_type = "EC2"
  desired_count   = 3

  load_balancer {
    target_group_arn = aws_alb_target_group.surfy-tg.arn
    container_name = "frontend-web"
    container_port = 3000
  }

  ordered_placement_strategy {
    type = "spread"
    field = "instanceId"
  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  depends_on = [aws_ecs_task_definition.frontend-image]
 
  tags = {
    Name = "Production ECS Service Frontend name"
    Environment = "production"
  }
}

resource "aws_ecs_task_definition" "frontend-image" {
  family                = "production-frontend"
  network_mode          = "bridge"
  container_definitions = jsonencode([
    {
      name      = "frontend-web"
      image     = "163668745705.dkr.ecr.eu-west-3.amazonaws.com/surfy-frontend:main"
      cpu       = 128 # cpu units (1024 for 1 ec2 cpu)
      memory    = 128
      essential = true
      portMappings = [
        {
          containerPort = 3000
          protocol      = "tcp"
        }
      ],
      environment: [
        {"name": "PORT", "value": "3000"},
      ]
    }
  ])
  tags = {
    Environment = "production"
  }
}