# vcp creation
resource "aws_vpc" "master" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.prefix}-${var.environment}-vpc"
  }

}

# # subnet creation
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.master.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "Ecs farget public subnet 1"
  }
}

# # subnet creation

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.master.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "Ecs farget public subnet 2"
  }
}

# #subnet creation

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.master.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "Ecs farget private subnet 1"
  }
}
resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.master.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "Ecs farget private subnet 2"
  }
}

# #internet gateway creation

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.master.id
  tags = {
    Name = "${var.environment}-igw"
  }
}

# #route table creation for public subnet 1

resource "aws_route_table" "public_1" {
  vpc_id = aws_vpc.master.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public route table 1"
  }
}

# #route table creation for public subnet 2

resource "aws_route_table" "public_2" {
  vpc_id = aws_vpc.master.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public route table 2"
  }
}

# #route table creation for private subnet 1
resource "aws_route_table" "private-1" {
  vpc_id = aws_vpc.master.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_1.id
  }
  tags = {
    Name = "private route table 1"
  }

}

# #route table creation for private subnet 2
resource "aws_route_table" "private-2" {
  vpc_id = aws_vpc.master.id
  route {
    cidr_block     = "0.0.0.0/24"
    nat_gateway_id = aws_nat_gateway.nat_2.id
  }
  tags = {
    Name = "private route table 2"
  }
}

# #nat gateway creation

resource "aws_nat_gateway" "nat_1" {
  allocation_id = aws_eip.nat_1.id
  subnet_id     = aws_subnet.public_1.id
  tags = {
    Name = "nat gateway 1"
  }
}

resource "aws_nat_gateway" "nat_2" {
  allocation_id = aws_eip.nat_2.id
  subnet_id     = aws_subnet.public_2.id
  tags = {
    Name = "nat gateway 2"
  }
}

# #2 elastic ip creation

resource "aws_eip" "nat_1" {
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name = "nat-1"
  }

}

resource "aws_eip" "nat_2" {
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name = "nat-2"
  }

}

# route table association for public subnet 1

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_1.id
}

# route table association for public subnet 2 

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public_2.id
}

# route table association for private subnet 1

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private-1.id
}

# route table association for private subnet 2

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private-2.id
}

# 2 private subnet for database

resource "aws_subnet" "db_subnet_1" {
  vpc_id            = aws_vpc.master.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "Ecs farget db subnet 1"
  }
}

resource "aws_subnet" "db_subnet_2" {
  vpc_id            = aws_vpc.master.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "Ecs farget db subnet 2"
  }
}

# #security group creation

resource "aws_security_group" "ALB" {
  vpc_id = aws_vpc.master.id
  name = "${var.environment}-ecs-alb-sg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ecs alb security group"
  }
}

resource "aws_security_group" "ecs" {
  vpc_id = aws_vpc.master.id
  name = "${var.environment}-ecs-sg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.ALB.id]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.ALB.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  tags = {
    Name = "ecs security group"
  }
}

resource "aws_security_group" "db" {
  vpc_id = aws_vpc.master.id
  name = "${var.environment}-ecs-db-sg"
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.ecs.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  tags = {
    Name = "ecs db security group"
  }
}

