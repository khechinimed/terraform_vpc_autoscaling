resource "aws_lb" "alb-public" {
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http.id]
  subnets            = module.discovery.public_subnets

  enable_deletion_protection = true


  tags = {
    Tier = "public",
    Name = "${var.app_name}-alb-public"
  }
}

# Target Group for the ALB

resource "aws_lb_target_group" "alb-public-tg" {
  port     = 8080
  protocol = "HTTP"
  vpc_id   = module.discovery.vpc_id

  tags = {
    Name = "${var.app_name}-HTTP"
  }

}

# Listener for the ALB

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb-public.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-public-tg.arn
  }
}

resource "aws_lb_target_group" "alb-public-tg-netdata" {
  port     = 3000
  protocol = "HTTP"
  vpc_id   = module.discovery.vpc_id

  tags = {
    Name = "${var.app_name}-HTTP-3000"
  }

}

resource "aws_lb_listener" "netdata" {
  load_balancer_arn = aws_lb.alb-public.arn
  port              = "3000"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-public-tg-netdata.arn
  }
}