resource "aws_launch_configuration" "ecs_launch_config" {
  image_id             = "ami-051dce30ef8253f67"
  iam_instance_profile = aws_iam_instance_profile.ecs_agent.name
  security_groups      = [aws_security_group.ecs_sg.id]
  user_data            = "#!/bin/bash\necho ECS_CLUSTER=my-cluster >> /etc/ecs/ecs.config"
  instance_type        = "t2.micro"
}

resource "aws_autoscaling_group" "failure_analysis_ecs_asg" {
  name                 = "asg"
  vpc_zone_identifier  = [aws_subnet.private_a.id, aws_subnet.private_b.id]
  launch_configuration = aws_launch_configuration.ecs_launch_config.name

  desired_capacity          = 2
  min_size                  = 1
  max_size                  = 3
  health_check_grace_period = 300
  health_check_type         = "EC2"
}

