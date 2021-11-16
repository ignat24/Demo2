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
  name = "Service-${var.app}-${var.env}"
  cluster = aws_ecs_cluster.ecs_main.id
  task_definition = aws_ecs_task_definition.task_def.arn
  desired_count = var.az_count
  deployment_minimum_healthy_percent = "30"

  placement_constraints {
    type = "distinctInstance"
  }
}