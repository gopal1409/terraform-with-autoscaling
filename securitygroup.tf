resource "aws_security_group" "myinstance" {
  vpc_id = aws_vpc.main.id
  name        = "myinstance"
  description = "security group for my instance"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
    Name = "myinstance"
  }
}
resource "aws_security_group" "elb-securitygroup" {
  name        = "elb"
  vpc_id      = aws_vpc.main.id
  description = "security group for load balancer"
  ingress {
    description = "allow-loadbalancer on port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]# allowing access from our example instance
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elb"
  }
}