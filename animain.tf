terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.65.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "my-vpc"
    }
}
resource "aws_subnet" "Private-subnet" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.my-vpc.id
    tags = {
      Name = "Private-subnet"
    }
  }

  resource "aws_subnet" "Public-subnet" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.my-vpc.id
    tags = {
      Name = "Public-subnet"
    }
  }

  resource "aws_internet_gateway" "my-igwa" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
      Name = "my-igwa"
    }
  }

  resource "aws_route_table" "my-routes" {
     vpc_id = aws_vpc.my-vpc.id
     route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my-igwa.id
     }
    }
  

resource "aws_route_table_association" "public-subk" {
  route_table_id = aws_route_table.my-routes.id
  subnet_id = aws_subnet.Public-subnet.id
}

resource "aws_instance" "my_server" {
  ami           = "ami-00d8aa800578d8b12"   
  instance_type = "t3.micro"
subnet_id = aws_subnet.Public-subnet.id
  tags = {
    Name        = "MyServerName12"  
    Environment = "Dev"
    Owner       = "Aniket"
  }
}
