data "aws_availability_zones" "avaliable" {}

variable "app" {
  default = "default_app_name"
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc_id" {
  
}
variable "public_subnet_ids" {
  type = set(string)
}

variable "private_subnet_ids" {
  type = set(string)
}
variable "env" {
  default = "default"
}

variable "az_count" {
  default = 2
}

variable "aws_dnc" {
  type = bool
  default = true
}

variable "aws_dnc_hostname" {
  type = bool
  default = true
}


variable "cidr_block_route" {
    default = "0.0.0.0/0"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default     = "myEcsTaskExecutionRole"
}

variable "app_port" {
  default = 80
}

variable "listener_port" {
  default = 80
}

variable "cpu_fargate" {
  default = 256
}

variable "memory_fargate" {
  default = 512
}

variable "container_ecr" {
  default = "873827770697.dkr.ecr.eu-central-1.amazonaws.com/project_prvt:latest"
}

variable "ecr_repository_url" {
  
}

variable "image_version" {
  default = "0.0.1"
}