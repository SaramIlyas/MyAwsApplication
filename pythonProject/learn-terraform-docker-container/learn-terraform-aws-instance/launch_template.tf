resource "aws_launch_template" "My_Launch_Template" {
  name          = "My_First_Launch_Template"
  instance_type = "t2.micro"
  image_id      = "ami-061dd8b45bc7deb3d"
  key_name      = "Mykeypair"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.first_sg.id]
  }

  user_data = filebase64("C:/Users/saram/Pycharmproject/pythonProject/learn-terraform-docker-container/learn-terraform-aws-instance/User_Data.sh")

  tags = {
    Name = "My_Launch_Template"
  }
}
