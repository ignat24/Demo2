# ecs.tf
provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {}
}
# Cluster======================= 
resource "aws_ecs_cluster" "ecs_main" {
  name = "Cluster-${var.env}-${var.app}"
}

# Task definition===============
resource "aws_ecs_task_definition" "task_definition" {
  family = "TD-${var.env}-${var.app}"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = var.cpu_fargate
  memory = var.memory_fargate
  container_definitions = jsonencode(
      [
          {
              name = "apache2-${var.env}"
              image = "${var.ecr_repository_url}:${var.image_version}"
              cpu = var.cpu_fargate
              memory = var.memory_fargate
              network_mode = "awsvpc"

              portMappings = [{
                  containerPort = var.app_port
                  hostPort = var.app_port
              }]
          }
      ]
  )
}

resource "aws_ecs_service" "ecs_service" {
  name = "Service-${var.env}-${var.app}"
  cluster = aws_ecs_cluster.ecs_main.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count = var.az_count
  launch_type = "FARGATE"

  lifecycle {
    ignore_changes = [desired_count]
    create_before_destroy = true
  }

  network_configuration {
    security_groups = [aws_security_group.sg_ecs.id]
    # subnets = aws_subnet.private_subnets[*].id
    subnets = var.private_subnet_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.tg_alb.id
    container_name = "apache2-${var.env}"
    container_port = var.app_port
  }

}