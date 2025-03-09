provider "aws" {
    region = "us-east-1"
  
}

resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "my_vpc"
    }
  
}

resource "aws_subnet" "Public_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1a"
    tags = {
      Name = "Public_Subnet"
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1a"
    tags = {
      name = "Private_Subnet"
    }
  
}

resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      name = "my_igw"
    }
  
}

resource "aws_route_table" "rt_public_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_igw.id
    }
  
}

resource "aws_route_table_association" "rt_public_association" {
    subnet_id = aws_subnet.Public_subnet.id
    route_table_id = aws_route_table.rt_public_subnet.id
  
}

resource "aws_security_group" "EC2_sg" {
    vpc_id = aws_vpc.my_vpc.id
    ingress  {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

resource "aws_instance" "EC2" {
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = aws_subnet.Public_subnet.id
    security_groups = [aws_security_group.EC2_sg.id]
    tags = {
      name = "VPC2"
    }
}


output "vpc_id" {
    description = "to check the vpc_id"
    value = aws_vpc.my_vpc.id
  
}