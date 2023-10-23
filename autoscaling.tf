resource "aws_launch_template" "surfy_launch" {
  image_id             = "ami-051dce30ef8253f67"
  
  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_agent.name
  }

  network_interfaces {
    security_groups      = [aws_security_group.ecs_sg.id]
  }
 
  user_data            = "${base64encode(data.template_file.ec2_user_data.rendered)}"
  instance_type        = "t2.micro"
}

data "template_file" "ec2_user_data" {
  template = "#!/bin/bash\necho ECS_CLUSTER=my-cluster >> /etc/ecs/ecs.config"
}

resource "aws_autoscaling_group" "failure_analysis_ecs_asg" {
  name                 = "asg"
  vpc_zone_identifier  = [aws_subnet.private_a.id, aws_subnet.private_b.id]
  launch_template {
   name = aws_launch_template.surfy_launch.name
  }

  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
}

