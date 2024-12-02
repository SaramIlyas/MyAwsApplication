# Security Group for Load Balancer
resource "aws_security_group" "elb_sg" {
  name        = "lb-security-group"
  description = "Allow HTTP traffic to the load balancer"
  vpc_id      = aws_vpc.vpc_1.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Target Group for Instances
resource "aws_lb_target_group" "my_target_group" {
  name        = "my-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc_1.id
  health_check {
    protocol            = "HTTP"
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }
}

# Application Load Balancer (ALB)
resource "aws_lb" "my_alb" {
  name            = "my-application-lb"
  internal        = false  # Set to true for internal LB
  security_groups = [aws_security_group.elb_sg.id]
  subnets         = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id, aws_subnet.subnet_3.id]

  enable_deletion_protection = false
  tags = {
    Name = "my-application-lb"
  }
}

# Listener for ALB
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}
