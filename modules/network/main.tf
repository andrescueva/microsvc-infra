resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "vpc"
  }
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

}


resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "igw"
  }
}

#public
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "main-public"
  }

}

resource "aws_subnet" "public_subnet1" {
  availability_zone = data.aws_availability_zones.azs.names[0]
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, 0)
  tags = {
    Name = "public-${data.aws_availability_zones.azs.names[0]}"
  }
}

resource "aws_subnet" "public_subnet2" {
  availability_zone = data.aws_availability_zones.azs.names[1]
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, 1)
  tags = {
    Name = "public-${data.aws_availability_zones.azs.names[1]}"
  }
}


resource "aws_route_table_association" "public_subnet1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_subnet2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public.id
}


#Private subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "private"
  }
}


resource "aws_subnet" "private_subnet1" {
  availability_zone = data.aws_availability_zones.azs.names[0]
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, 2)
  tags = {
    Name = "private-${data.aws_availability_zones.azs.names[0]}"
  }

}


resource "aws_subnet" "private_subnet2" {
  availability_zone = data.aws_availability_zones.azs.names[1]
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, 3)
  tags = {
    Name = "private-${data.aws_availability_zones.azs.names[1]}"
  }
}


resource "aws_route_table_association" "private_subnet1" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_subnet2" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private.id
}

