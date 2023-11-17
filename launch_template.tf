resource "aws_launch_template" "nginx" {
  name_prefix = "nginx-launch_template"

  image_id = "ami-0acd4d8923fe8ca56"

  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.allow_http_proxy.id]

  key_name = "khechini-key"

}