resource "aws_lb" "ecs-alb" {
  name               = "Surfy-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id]
  security_groups    = [aws_security_group.alb_sg.id]

  idle_timeout = 30
  enable_http2 = true

  enable_deletion_protection = true

  tags = {
    Name = "production-alb"
    Environment = "production"
  }
}

resource "aws_alb_target_group" "surfy-tg" {
  name          = "surfy-target-group"
  port          = 80
  protocol      = "HTTP"
  vpc_id        = aws_vpc.vpc.id

  deregistration_delay = 5

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 6
    interval            = 30
    path                = "/health_check"
    matcher             = "200"
  }

  depends_on = [aws_lb.ecs-alb]

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "frontend-http-listener" {
  load_balancer_arn = aws_lb.ecs-alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.surfy-tg.arn
    type             = "forward"
  }
}