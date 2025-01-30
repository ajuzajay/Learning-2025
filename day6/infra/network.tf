# vcp creation
resource "aws_vpc" "master" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.prefix}-${var.environment}-vpc"
  }
  
}

# subnet creation
resource "aws_subnet" "public_1" {
  vpc_id = "${aws_vpc.master.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0] 
  map_public_ip_on_launch = true
  tags = {
    Name = "Ecs farget public subnet 1"   
  }
}

# subnet creation

resource "aws_subnet" "public_2" {
  vpc_id = "${aws_vpc.master.id}"
  cidr_block = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "Ecs farget public subnet 2"   
  }

#subnet creation

resource "aws_subnet" "private_1" {
  vpc_id = "${aws_vpc.master.id}"
  cidr_block = "10.0.3.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "Ecs farget private subnet 1"   
  }
}

