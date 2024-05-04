resource"aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/0"
    enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "new_VPC"
  }
}

#internetgatway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "InternetGateway"
  }
}



resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

#elatic ip

resource "aws_eip" "eip" {
  vpc = true
  depends_on = ["aws_internet_gateway.gw"]
}

#nat gateway

resource "aws_nat_gateway" "nat" {
 allocation_id = aws_eip.eip.id
 subnet_id = aws_subnet.public_subnet.vpc_id
 depends_on = [ "aws_internet getway.gw" ]
  
}

#public subnet

resource "aws_subnet" "public_subnet" {
vpc_id = aws_vpc.vpc.id
cidr_block = "10.0.0.0/0"
map_public_ip_on_launch = true 
availability_zone = "eu-north-1"
tags = {
  Name = "publicsubnet"
}
 }
   
   resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags {
    Name = "public_route"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}


#private subnet

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.0.0/0"
  availability_zone = "eu-north-1b"
  tags = {
    Name = "privatesubnet"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags {
    Name = "private_route"
  }
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}


#private subnet2

resource "aws_subnet" "private_subnet1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-north-1c"
  tags = {
    Name = "privatesubnet2"
  }
}

resource "aws_route_table" "private_route_table1" {
  vpc_id = aws_vpc.vpc.id
  tags {
    Name = "private_route2"
  }
}

resource "aws_route_table_association" "private_subnet_association1" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_route_table1.id
}



