# Auto Scaling Group Block
resource "aws_autoscaling_group" "my_ASG" {
  desired_capacity     = 2
  max_size             = 4
  min_size             = 2
  vpc_zone_identifier  = [
    aws_subnet.subnet_1.id,
    aws_subnet.subnet_2.id,
    aws_subnet.subnet_3.id
  ]

  launch_template {
    id      = aws_launch_template.My_Launch_Template.id
    version = "$Latest"
  }

  health_check_type          = "ELB"
  health_check_grace_period  = 300

  tag {
    key                 = "Name"
    value               = "AutoScalingInstance"
    propagate_at_launch = true
  }

  # Attach to the Target Group
  target_group_arns = [aws_lb_target_group.my_target_group.arn]
}
