# PUBLIC SUBNET
resource "aws_subnet" "public_a" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = "10.0.1.0/24"
    availability_zone       = "eu-west-3a"
    tags = {
        Name: "Surfy Public subnet Zone A"
        Environment = "production"
    }
}

resource "aws_subnet" "public_b" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = "10.0.51.0/24"
    availability_zone       = "eu-west-3b"
    tags = {
        Name: "Surfy Public subnet Zone B"
        Environment = "production"
    }
}

resource "aws_subnet" "private_a" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = "10.0.2.0/24"
    availability_zone       = "eu-west-3a"
    tags = {
        Name: "Surfy Private subnet Zone A"
        Environment = "production"
    }
}

resource "aws_subnet" "private_b" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = "10.0.52.0/24"
    availability_zone       = "eu-west-3b"
    tags = {
        Name: "Surfy Private subnet Zone B"
        Environment = "production"
    }
}