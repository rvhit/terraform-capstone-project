resource "aws_lb" "my_bg_alb" {
  name               = "blue-green-alb-r"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.my_bg_subnet.id, aws_subnet.my_bg_subnet_2.id]
  security_groups    = [aws_security_group.my_bg_web_sg.id]
}

resource "aws_lb_target_group" "my_bg_blue_tg" {
  name     = "blue-target-group-r"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_bg_vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
}

resource "aws_lb_target_group_attachment" "my_bg_blue_attach" {
  target_group_arn = aws_lb_target_group.my_bg_blue_tg.arn
  target_id        = aws_instance.my_bg_blue.id
  port             = 80
}

resource "aws_lb_target_group" "my_bg_green_tg" {
  name     = "green-target-group-r"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_bg_vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
}

resource "aws_lb_target_group_attachment" "my_bg_green_attach" {
  target_group_arn = aws_lb_target_group.my_bg_green_tg.arn
  target_id        = aws_instance.my_bg_green.id
  port             = 80
}

resource "aws_lb_listener" "my_bg_front_end" {
  load_balancer_arn = aws_lb.my_bg_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    # target_group_arn = aws_lb_target_group.my_bg_blue_tg.arn #For blue environment
    target_group_arn = aws_lb_target_group.my_bg_green_tg.arn #For green environment

  }
}
