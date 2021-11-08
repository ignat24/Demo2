resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity = 3
  min_capacity = 2
  resource_id = "service/${aws_ecs_cluster.ecs_main.name}/${aws_ecs_service.ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_policy_up" {
  name = "${var.app}-${var.env}-scale-up"
  policy_type = "StepScaling"
  resource_id = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace = aws_appautoscaling_target.ecs_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type = "ChangeInCapacity"
    cooldown = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
        metric_interval_upper_bound = 0
        scaling_adjustment = 1
    }
  }
}

resource "aws_appautoscaling_policy" "ecs_policy_down" {
  name = "${var.app}-${var.env}-scale-down"
  policy_type = "StepScaling"
  resource_id = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace = aws_appautoscaling_target.ecs_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type = "ChangeInCapacity"
    cooldown = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
        metric_interval_upper_bound = 0
        scaling_adjustment = -1
    }
  }
}