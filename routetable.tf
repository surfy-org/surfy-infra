# ROUTE TABLE

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.vpc.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }
    tags = {
        Name = "Surfy public route table"
        Environment = "production"
    }
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.vpc.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.public_a.id
    }
    tags = {
        Name = "Surfy private route table"
        Environment = "production"
    }
}


# ROUTE TABLE ASSOCIATION 

resource "aws_route_table_association" "public_a" {
  subnet_id = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_a" {
  subnet_id = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}

# NAT GATEWAY

resource "aws_nat_gateway" "public_a" {
    allocation_id = aws_eip.public_a.id
    subnet_id     = aws_subnet.public_a.id

    tags = {
        Name = "Production NAT Gateway Zone A"
        Environment = "production"
    }
}

resource "aws_nat_gateway" "public_b" {
    allocation_id = aws_eip.public_b.id
    subnet_id     = aws_subnet.public_b.id

    tags = {
        Name = "Production NAT Gateway Zone B"
        Environment = "production"
    }
}

resource "aws_eip" "public_a" {
  depends_on = [aws_internet_gateway.internet_gateway]

  tags = {
    Name: "Production Elastic IP Zone A"
    Environment = "production"
  }
}

resource "aws_eip" "public_b" {
  depends_on = [aws_internet_gateway.internet_gateway]

  tags = {
    Name: "Production Elastic IP Zone B"
    Environment = "production"
  }
}