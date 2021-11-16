data "aws_ami" "linux2_ecs" {
  owners = ["amazon"]
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }
}

resource "aws_launch_configuration" "ec2_launch" {
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ecs_agent.name
  image_id = data.aws_ami.linux2_ecs.id
  # image_id = "ami-088d915ff2a776984"
  security_groups = [aws_security_group.sg_ecs.id]
  user_data = "#!/bin/bash\necho ECS_CLUSTER=Cluster-${var.env}-${var.app} > /etc/ecs/ecs.config"
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "autoscaling" {
  name = "AS-${var.app}-${var.env}"
  launch_configuration = aws_launch_configuration.ec2_launch.name
  target_group_arns = [aws_alb_target_group.tg_alb.arn]
  vpc_zone_identifier = var.private_subnet_ids
  
  
  health_check_grace_period = 60
  health_check_type = "EC2"
  force_delete = true
  
  

  min_size = 2
  max_size = 4
  desired_capacity = var.az_count
  
  lifecycle {
    create_before_destroy = true


  }
}




# resource "aws_appautoscaling_target" "ecs_target" {
#   max_capacity = 4
#   min_capacity = 2
#   resource_id = "service/${aws_ecs_cluster.ecs_main.name}/${aws_ecs_service.service.name}"
#   scalable_dimension = "ecs:service:DesiredCount"
#   service_namespace = "ecs"
# }

# resource "aws_appautoscaling_policy" "ecs_policy_up" {
#   name = "${var.app}-${var.env}-scale-up"
#   policy_type = "StepScaling"
#   resource_id = aws_appautoscaling_target.ecs_target.resource_id
#   scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
#   service_namespace = aws_appautoscaling_target.ecs_target.service_namespace

#   step_scaling_policy_configuration {
#     adjustment_type = "ChangeInCapacity"
#     cooldown = 60
#     metric_aggregation_type = "Maximum"

#     step_adjustment {
#         metric_interval_upper_bound = 0
#         scaling_adjustment = 1
#     }
#   }
# }

# resource "aws_appautoscaling_policy" "ecs_policy_down" {
#   name = "${var.app}-${var.env}-scale-down"
#   policy_type = "StepScaling"
#   resource_id = aws_appautoscaling_target.ecs_target.resource_id
#   scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
#   service_namespace = aws_appautoscaling_target.ecs_target.service_namespace

#   step_scaling_policy_configuration {
#     adjustment_type = "ChangeInCapacity"
#     cooldown = 60
#     metric_aggregation_type = "Maximum"

#     step_adjustment {
#         metric_interval_upper_bound = 0
#         scaling_adjustment = -1
#     }
#   }
# }