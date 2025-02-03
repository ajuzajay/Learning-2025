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
resource "aws_subnet" "private_2" {
  vpc_id = "${aws_vpc.master.id}"
  cidr_block = "10.0.4.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "Ecs farget private subnet 2"   
  }
}

#internet gateway creation

resource "aws_internet_gateway" "master" {
  vpc_id = "${aws_vpc.master.id}"
  tags = {
    Name = "${var.environment}-igw"
  }
}

#route table creation

resource "aws_route_table" "public_1" {
  vpc_id = "${aws_vpc.master.id}"
  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = "${aws_internet_gateway.master.id}"
  }
  tags = {
    Name = "Ecs farget public route table 1"
  }
}

resource "aws_route_table" "public_2" {
  vpc_id = "${aws_vpc.master.id}"
  route {
    cidr_block = "10.0.2.0/24"
    gateway_id = "${aws_internet_gateway.master.id}"
  }
  tags = {
    Name = "Ecs farget public route table 2"
  }
}

#route table association

##