#internet VPC
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"
  tags = {
    Name = "gopal vpc"
  }
}

#subnets
resource "aws_subnet" "app-public-1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2a"
  tags = {
    Name = "app-public-1"
  }
}

resource "aws_subnet" "app-public-2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2b"
  tags = {
    Name = "app.public-2"
  }
}

resource "aws_subnet" "app-public-3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2c"
  tags = {
    Name = "app.public-3"
  }
}
resource "aws_subnet" "app-private-1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-2a"
  tags = {
    Name = "backend.private-1"
  }
}

resource "aws_subnet" "app-private-2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-east-2b"
  tags = {
    Name = "backend.private-2"
  }
}

resource "aws_subnet" "app-private-3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "us-east-2c"
  tags = {
    Name = "backend.private-3"
  }
}

#route tables
resource "aws_route_table" "main-public" {
    vpc_id = aws_vpc.main.id 
    route { 
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main-gw.id 
    }
    tags = {
        Name = "main-public-1"
    }
}
#resource internet gw
resource "aws_internet_gateway" "main-gw"{
    vpc_id = aws_vpc.main.id 
    tags = {
        Name = "app_internet_gw"
    }
}
#assocaite the route with internet gateway_id
resource "aws_route_table_association" "app-public-1a" {
    subnet_id = aws_subnet.app-public-1.id
    route_table_id = aws_route_table.main-public.id
}
resource "aws_route_table_association" "app-public-2a" {
    subnet_id = aws_subnet.app-public-2.id
    route_table_id = aws_route_table.main-public.id
}
resource "aws_route_table_association" "app-public-3a" {
    subnet_id = aws_subnet.app-public-3.id
    route_table_id = aws_route_table.main-public.id
}