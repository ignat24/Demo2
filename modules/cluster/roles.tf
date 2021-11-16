# data "aws_iam_policy_document" "ecs_task_execution_role" {
#   version = "2012-10-17"
#   statement {
#     sid     = ""
#     effect  = "Allow"
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["ecs-tasks.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_role" "ecs_task_execution_role" {
#   name               = "EcsTaskExecutionRole-${var.env}-${var.aws_region}"
#   assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
# }

# resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
# }

# resource "aws_iam_instance_profile" "ecs_profile" {
#   name = "ecs-agent-${var.env}-${var.aws_region}"
#   role = aws_iam_role.ecs_role.name

# }

# resource "aws_iam_role" "ecs_role" {
#   name = "ECS-Role-${var.app}-${var.env}"
#   assume_role_policy = data.aws_iam_policy_document.assume_role_task.json
# }
# # data "aws_iam_policy_document" "consul_task_policy" {
# #   statement {
# #     actions = [
# #       "ec2:Describe*",
# #       "autoscaling:Describe*",
# #     ]

# #     resources = ["*"]
# #   }
# # }

# data "aws_iam_policy_document" "assume_role_task" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["ec2.amazonaws.com"]
#     }
#   }
#   }

# resource "aws_iam_role_policy_attachment" "ecs_attach" {
#     role = aws_iam_role.ecs_role.name
#     policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
#   }


# Roles for EC2 profile=============================
data "aws_iam_policy_document" "ec2_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2_role" {
  name               = "ecs-agent-${var.aws_region}"
  assume_role_policy = data.aws_iam_policy_document.ec2_policy.json
}

resource "aws_iam_role_policy_attachment" "ec2_atach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ecs-agent-${var.aws_region}"
  role = aws_iam_role.ec2_role.name
}
# =============================================