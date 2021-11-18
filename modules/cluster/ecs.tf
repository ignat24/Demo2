# ecs.tf
provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {}
}

# Cluster======================= 
resource "aws_ecs_cluster" "ecs_main" {
  name = "Cluster-${var.env}-${var.app}"
  capacity_providers = [aws_ecs_capacity_provider.test.name]
  
}

# Task definition======================= 
resource "aws_ecs_task_definition" "task_def" {
  family = "service"
  container_definitions = jsonencode([
    {
      name = "apache2-${var.app}-${var.env}"
      image = "${var.ecr_repository_url}:${var.image_version}"
      cpu = var.cpu_fargate
      memory = var.memory_fargate
      essential = true
      
      portMappings = [
        {
        containerPort = var.app_port
        hostPort = var.app_port
        }
      ]
    }
  ])
}

# Service======================= 
resource "aws_ecs_service" "service" {
depends_on = [
  aws_ecs_capacity_provider.test
]
  name = "Service-${var.app}-${var.env}"
  cluster = aws_ecs_cluster.ecs_main.id
  task_definition = aws_ecs_task_definition.task_def.arn
  desired_count = var.az_count
  deployment_minimum_healthy_percent = "30"

  # placement_constraints {
  #   type = "distinctInstance"
  # }
  
}
resource "aws_ecs_capacity_provider" "test" {
  # roling_update
  name = "test"
  
  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.autoscaling.arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      maximum_scaling_step_size = 2
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 30
      
    }
  }

}

# resource "aws_appautoscaling_target" "ecs_target" {
#   max_capacity = var.az_count*2
#   min_capacity = var.az_count
#   resource_id = "service/${aws_ecs_cluster.ecs_main.name}/${aws_ecs_service.service.name}"
#   role_arn = "arn:aws:iam::873827770697:role/aws-service-role/ecs.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_ECSService"
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