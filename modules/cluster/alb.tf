# alb.tf


# Application load balancer======
resource "aws_alb" "alb" {
  name = "ALB-${var.env}-${var.app}"
  load_balancer_type = "application"
  # subnets = aws_subnet.public_subnets[*].id
  subnets = var.public_subnet_ids
  security_groups = [aws_security_group.sg_alb.id]

  tags = {
    "Name" = "ALB-${var.env}-${var.app}"
  }
}


# Application load balancer target group========
resource "aws_alb_target_group" "tg_alb" {
  port = var.app_port
  protocol = "HTTP"
  target_type = "ip"
  # vpc_id = aws_vpc.main_vpc.id
  vpc_id = var.vpc_id

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }

  tags = {
    "Name" = "ALB-TG-${var.env}-${var.app}"
  }
}


# Application load balancer listener
resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.alb.arn
  port = var.listener_port
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.tg_alb.arn
    type = "forward"
  }
}
