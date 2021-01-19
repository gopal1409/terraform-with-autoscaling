# launch configuration
resource "aws_launch_configuration" "example-launchconfig" {
  name_prefix   = "example-launchconfig"
  image_id      = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  key_pair = aws_key_pair.mykeypair.key_name
  security_group = [aws_security_group.myinstance.id]
  user_data = "#!/bin/bash\napt-get update\napt-get -y install net-tools nginx\nMYIP=`ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'this is: '$MYIP > /var/www/html/index.html"
  lifecycle {
    create_before_destroy = true
  }
}


#autoscaling group 
resource "aws_autoscaling_group" "example-autoscaling" {
  name                      = "example-autoscaling"
  max_size                  = 4
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  load_balancers = [aws_elb.my-elb.name]
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.example-launchconfig.name
  tags {
      key = "Gopal"
      value = "Autoscaling Instance"
      propogate_at_launch = true
  }
}