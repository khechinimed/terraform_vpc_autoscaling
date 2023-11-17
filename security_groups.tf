resource "aws_security_group" "allow_http" {
  description = "Allow http inbound traffic"
  vpc_id      = module.discovery.vpc_id
  name        = "${var.app_name}-alb"

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.app_name}-alb"
  }
}

resource "aws_security_group_rule" "allow_http-80" {
  description       = "Allow http inbound traffic"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_http.id
}

resource "aws_security_group_rule" "allow_http-3000" {
  description       = "Allow http inbound traffic"
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_http.id
}

resource "aws_security_group" "allow_http_proxy" {
  description = "Allow http inbound traffic to 8080"
  vpc_id      = module.discovery.vpc_id
  name        = "${var.app_name}-asg"

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.app_name}"
  }
}

resource "aws_security_group_rule" "allow_http-8080" {
  description              = "Allow http on 8080 inbound traffic"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.allow_http.id
  security_group_id        = aws_security_group.allow_http_proxy.id
}

resource "aws_security_group_rule" "allow_netdata" {
  description              = "Allow netdata on 3000 inbound traffic"
  type                     = "ingress"
  from_port                = 3000
  to_port                  = 3000
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.allow_http.id
  security_group_id        = aws_security_group.allow_http_proxy.id
}