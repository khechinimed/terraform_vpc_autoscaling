resource "aws_autoscaling_group" "bar" {
  vpc_zone_identifier = module.discovery.private_subnets
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1
  target_group_arns   = [aws_lb_target_group.alb-public-tg.arn, aws_lb_target_group.alb-public-tg-netdata.arn]

  launch_template {
    id      = aws_launch_template.nginx.id
    version = "$Latest"
  }
}